// primitives.scad — geometry primitives shared across gerotor files.
// No gerotor-specific parameters here; callers pass everything explicitly.

// ---- Trochoid ---------------------------------------------------------------
// Point list for a trochoid member with `n` teeth and base radius `r1`.
// Rolling relation: r2 = r1/(n-1); a2 = a1 * r1/r2.
// Faithful to the original 2014 rtroch_b, verified against it.
function trochoid(n, r1, steps) =
    let (r2 = r1 / (n - 1))
    [ for (i = [0 : steps - 1])
        let (a1 = i * 360 / steps,
             a2 = a1 * r1 / r2)
        r1 * [sin(a1), cos(a1)] + r2 * [-sin(a2), cos(a2)]
    ];

// ---- Shoelace area ----------------------------------------------------------
// Area of a closed 2-D point list (mm²). Cross-terms summed via dot with a
// ones-vector (OpenSCAD has no built-in sum).
function polyArea(p) =
    let (cross = [ for (i = [0 : len(p) - 1])
                     let (j = (i + 1) % len(p))
                     p[i].x * p[j].y - p[j].x * p[i].y ],
         ones  = [ for (i = [0 : len(p) - 1]) 1 ])
    abs(0.5 * (cross * ones));

// ---- Wedge prism (2-D, for intersection) ------------------------------------
// A 2-D sector of radius `r` centred at `mid`, spanning `arc` degrees.
// Fanned in <=90° convex sub-sectors so CSG intersection is always clean.
module wedgePrism(mid, arc, r) {
    seg  = 90;
    nseg = max(1, ceil(arc / seg));
    step = arc / nseg;
    a0   = mid - arc / 2;
    union() for (k = [0 : nseg - 1]) {
        b0 = a0 + k * step;
        b1 = b0 + step;
        polygon([[0, 0],
                 2 * r * [cos(b0), sin(b0)],
                 2 * r * [cos(b1), sin(b1)]]);
    }
}

// ---- Kidney solid -----------------------------------------------------------
// An annular sector between radii `rin`..`rout`, spanning `arc` degrees centred
// at `mid`, extruded to height `hgt` (centred on z=0).
// Pure CSG (annular tube ∩ wedge prism) — always 2-manifold.
module kidneySolid(mid, arc, rin, rout, hgt) {
    linear_extrude(hgt, center = true)
    intersection() {
        difference() {
            circle(r = rout, $fn = 160);
            circle(r = rin,  $fn = 160);
        }
        wedgePrism(mid, arc, rout + 1);
    }
}
