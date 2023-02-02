module rounded_cube(size,r) {
    union()
    {
        height = size[2];
        echo(height);
        translate([r,r,0])
            cylinder(h=height, r=r, $fn=32);
        translate([size[0]-r,r,0])
            cylinder(h=height, r=r, $fn=32);
        translate([size[0]-r,size[1]-r,0])
            cylinder(h=height, r=r, $fn=32);
        translate([r,size[1]-r,0])
            cylinder(h=height, r=r, $fn=32);
        translate([r,0,0])
            cube([size[0]-2*r, size[1], size[2]]);
        translate([0,r,0])
            cube([size[0], size[1]-2*r, size[2]]);
    }
}
module box() {
    union() {
        w=58;
        d=92;
        h=120;
        th = 0.4; //thickness inside
        th2 = 0.8; //thickness outside
        
        difference() {
            rounded_cube([w,d,h],3);
            translate([th2,th2,1.2])
                rounded_cube([w-2*th2,d-2*th2,h],3);
        }
        dw = w/3;
        for(i=[dw:dw:w-th]) {
            translate([i-th/2,0,0])
                cube([th,d,h]);
        }
        dd = d/4;
        for(i=[dd:dd:d-th]) {
            translate([0,i-th/2,0])
                cube([w,th,h]);
        }
        
        for(j=[dw:dw:w-th]) {
            for(k=[dd:dd:d-th]) {
                translate([j,k,h/2])
                    rotate([0,0,45])
                        cube([th*2.5,th*2.5,h],center=true);
            }
        }
        for( y = [92/2 + 46/2, 92/2 - 46/2]) {
            for( z = [10,110]) {
                translate([w,y,z]) rotate([0,90,0])
                    cylinder(h=1.5, d1=7, d2 = 5);
            }
        }
    }
}

difference() {
    box();
    for( y = [92/2 + 46/2, 92/2 - 46/2]) {
        for( z = [10,110]) {
            translate([0,y,z]) rotate([0,90,0])
                cylinder(h=4, d=8, center=true);
        }
    }
}      