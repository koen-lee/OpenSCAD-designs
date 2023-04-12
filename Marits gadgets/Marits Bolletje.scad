difference() {
    sphere(25, $fn=300);
    linear_extrude(60, center=false)
        text("M&O", 10, /*"Courier New"*/"Comic Sans MS:style=Regular", halign="center", valign = "center");
}