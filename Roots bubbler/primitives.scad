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

// ---- GT2 5mm tooth profile --------------------------------------------------
// Polygon from the GT2_5mm module in parametricPulley.scad (droftarts/0scar).
// Y+ is the tooth tip (outward), Y=0 is the pitch line, Y=-0.75 is the belt land.
// Extruded along Z, centred on Z=0. Caller translates to the pitch radius and
// applies tooth-width scaling.
module gt2_5mm_tooth(ht) {
    linear_extrude(height = ht + 2, center = true)
        polygon([[-1.975908,-0.75],[-1.975908,0],[-1.797959,0.03212],[-1.646634,0.121224],
                 [-1.534534,0.256431],[-1.474258,0.426861],[-1.446911,0.570808],
                 [-1.411774,0.712722],[-1.368964,0.852287],[-1.318597,0.989189],
                 [-1.260788,1.123115],[-1.195654,1.25375],[-1.12331,1.380781],
                 [-1.043869,1.503892],[-0.935264,1.612278],[-0.817959,1.706414],
                 [-0.693181,1.786237],[-0.562151,1.851687],[-0.426095,1.9027],
                 [-0.286235,1.939214],[-0.143795,1.961168],[0,1.9685],
                 [0.143796,1.961168],[0.286235,1.939214],[0.426095,1.9027],
                 [0.562151,1.851687],[0.693181,1.786237],[0.817959,1.706414],
                 [0.935263,1.612278],[1.043869,1.503892],[1.123207,1.380781],
                 [1.195509,1.25375],[1.26065,1.123115],[1.318507,0.989189],
                 [1.368956,0.852287],[1.411872,0.712722],[1.447132,0.570808],
                 [1.474611,0.426861],[1.534583,0.256431],[1.646678,0.121223],
                 [1.798064,0.03212],[1.975908,0],[1.975908,-0.75]]);
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
