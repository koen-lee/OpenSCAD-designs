// chamber_map.scad — diagnostic port-placement overlay.
// Open this file directly in OpenSCAD to inspect chamber geometry, port arcs,
// and bearing reference rings. Not part of the printable model.
//
// All gerotor parameters are inherited from gerotor.scad via include so this
// file always reflects the current design without duplication.

include <gerotor.scad>

// ---- Thin ring outline at a given z height ----------------------------------
module ringZ(r, col, z, t = 0.5) {
    color(col) translate([0, 0, z])
    linear_extrude(0.6)
        difference() {
            circle(r = r + t, $fn = 200);
            circle(r = r - t, $fn = 200);
        }
}

// ---- Chamber map ------------------------------------------------------------
// Layers (each at a distinct z to avoid z-fighting):
//   0.0  cyan    gas pockets (outer pocket minus inner lobe)
//   0.7  yellow  inner-rotor face footprint (shows which band it sweeps)
//   1.0  green   intake kidney
//   1.0  red     outlet kidney
//   2.0  rings   bearing OD/ID, min-shaft bore, rotor outer edge
//   3.0  dots    outer axis (black), inner axis (yellow-green)
module chamberMap() {
    aO = -(rpm_demo * 360 * $t) / (N + 1);
    aI = -(rpm_demo * 360 * $t) / N;

    // (1) gas pockets
    color([0.30, 0.75, 0.85, 0.5]) linear_extrude(0.6)
    difference() {
        rotate(aO) offset(r =  pinOut) polygon(trochoid(N + 1, ro, fn));
        translate([0, e]) rotate(aI) offset(r = -pinIn) polygon(trochoid(N, ri, fn));
    }

    // (2) inner-rotor face footprint (faint yellow — shows sealing band)
    color([0.95, 0.9, 0.4, 0.35]) translate([0, 0, 0.7])
        translate([0, e]) rotate(aI) linear_extrude(0.3)
            offset(r = -pinIn) polygon(trochoid(N, ri, fn));

    // (3) kidney ports — green=intake, red=outlet
    color([0.10, 0.70, 0.20, 0.85]) translate([0, 0, 1])
        kidneySolid(intakeMid, portArc, portRin, portRout, 0.6);
    color([0.85, 0.20, 0.10, 0.85]) translate([0, 0, 1])
        kidneySolid(outletMid, portArc, portRin, portRout, 0.6);

    // (4) reference rings
    ringZ(outB_od / 2,       [0.30, 0.30, 0.40], 2);    // bearing OD (current)
    ringZ(outB_id / 2,       [0.55, 0.55, 0.65], 2);    // bearing ID (current)
    ringZ(e + innB_id/2 + 2, [0.90, 0.10, 0.10], 2.2);  // min bore if only shaft passes
    ringZ(ro,                [0.95, 0.55, 0.00], 2);    // rotor pocket outer edge

    // (5) axis markers
    color("black")     translate([0, 0, 3]) cylinder(r = 0.8, h = 0.6, $fn = 16);
    color([0.7, 0.7,0]) translate([0, e, 3]) cylinder(r = 0.8, h = 0.6, $fn = 16);
}

chamberMap();
