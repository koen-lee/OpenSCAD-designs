difference() {
    sphere(25, $fn=150);
    linear_extrude(60, center=false, convexity=10)
        text("Marit", 10, /*"Courier New"*/"Comic Sans MS:style=Regular", halign="center", valign = "center");
}