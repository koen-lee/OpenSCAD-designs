$fn=64;
module mount() {
    difference() {
        union() {
            hull() {
                cylinder(d=11, h=9.5, center=true);
                translate([0,5,0])
                    cube([11,2,9.5],center=true);
            }
            translate([-11/2,5,-2.2])
                    cube([4.4,8,4.4]);
            translate([-11/2+4.4+2,5,-2.2])
                    cube([4.4,8,4.4]);
            
        }
        cylinder(d=5.5, h=100,center=true);
    }
}

module mount2(){
    dx=2;
    difference(){
        union(){
            translate([dx,-13])
                cylinder(d=10, h=6);
            translate([dx,13])
                cylinder(d=10, h=6);    
            hull() {
                translate([dx,-13,-2])
                    cylinder(d=10, h=2);
                translate([dx,13,-2])
                    cylinder(d=10, h=2); 
                
                translate([0,0,-2+1])
                    cube([11,9.5,2],center=true);
            }
        }
       translate([dx,-13])
            cylinder(d=5, h=50,center=true);
        translate([dx,13])
            cylinder(d=5, h=50,center=true);    
    }
}

translate([0,0,-8])
rotate([90,0,0])
    mount();

mount2();