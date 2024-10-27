module mesh() {

    difference() {
        thickness = 1;
        size_x=55;
        size_y=40;
        holes_x=9;
        holes_y=7;
        
        hole_x = (size_x - thickness) / holes_x - thickness;
        hole_y = (size_y - thickness) / holes_y - thickness;
        echo([hole_x,hole_y]);
        cube([55,40,20]);
        for(dx=[0:holes_x-1]) {
            for(dy=[0:holes_y-1]) {
                translate([thickness + dx * (hole_x+thickness),         thickness + dy * (hole_y+thickness),-1])
                    cube([hole_x, hole_y, 100]);
            }
        }
        translate([thickness, thickness,2])
        cube([size_x-2*thickness,size_y-2*thickness,100]);
        
        for(dx=[0:holes_x-1]) {
        
                translate([thickness + dx * (hole_x+thickness),         thickness,1.6])
                    cube([hole_x, size_y-2*thickness, 100]);
        }
    }
}

mesh();
