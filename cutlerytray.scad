thickness = 0.85;
size_x=55;
size_y=40;

module mesh() {
    holes_x=9;
    holes_y=7;
    
    hole_x = (size_x - thickness) / holes_x;
    hole_y = (size_y - thickness) / holes_y;
    echo([hole_x,hole_y]);
    
        /*
        for(dx=[0.5:holes_x-1]) {
            for(dy=[0.5:holes_y-1]) {
                translate([thickness + dx * (hole_x+thickness),         thickness + dy * (hole_y+thickness),-1])
                    cube([hole_x, hole_y, 100]);
            }
        }*/
        
        
        for(dx=[1:holes_x-1]) {
                translate([dx * hole_x,thickness])
                    cube([thickness, size_y-2*thickness, 2]);
        }
        for(dy=[1:holes_y-1]) {
                translate([thickness, dy * hole_y,0.4])
                    cube([size_x-2*thickness, thickness, 2]);
        }
       
     
}

module border() {
    rad = 4;
    $fn=32;
    difference() {
        hull() {
            translate([rad,rad])
                cylinder(r=rad,h=20);
            translate([size_x-rad,rad])
                cylinder(r=rad,h=20);
            translate([size_x-rad,size_y-rad])
                cylinder(r=rad,h=20);
            translate([rad,size_y-rad])
                cylinder(r=rad,h=20);
        }
        translate([0,0,-1])
        hull() {
            translate([rad,rad])
                cylinder(r=rad-thickness,h=22);
            translate([size_x-rad,rad])
                cylinder(r=rad-thickness,h=22);
            translate([size_x-rad,size_y-rad])
                cylinder(r=rad-thickness,h=22);
            translate([rad,size_y-rad])
                cylinder(r=rad-thickness,h=22);
        }
    }
}
intersection() {
    difference() {
        union() {
            mesh();
            border();
            translate([18,0])
                rotate([20,0])
                cube([7,6.5,15]);
            translate([size_x, size_y])
                mirror([0,1,0])
                mirror([1,0,0])
                translate([18,0])
                rotate([20,0])
                    cube([7,6.5,15]);
        }
        
        translate([19,-1,-1])
            rotate([20,0])
            cube([5,6.5,17]);
        
        translate([size_x, size_y])
            mirror([0,1,0])
            mirror([1,0,0])
            translate([19,-1,-1])
            rotate([20,0])
                    cube([5,6.5,17]);
        
    }
    hull(){ border(); }
}