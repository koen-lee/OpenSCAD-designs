module mesh() {

    difference() {
        thickness = 1;
        size_x=55;
        size_y=40;
        cube([55,40,20]);
     
        translate([thickness, thickness,3])
        cube([size_x-2*thickness,size_y-2*thickness,100]);
    }
}

mesh();
