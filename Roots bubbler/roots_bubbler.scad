include <roots.scad>;

tolerance =  1;
difference() {
    
    color("green")
    union()
    {
        translate([0,-60])
            cylinder(h=90,r=80, center=true, $fn=360);
            
        translate([0,60])
            cylinder(h=90,r=80, center=true, $fn=360);
        hull() {
            cube([120,20,90], center=true);
            rotate([0,90])
            cylinder(200, d=20, center=true);
        }        
        rotate([0,90])
        cylinder(280, d=20, center=true);
    }
        
    translate([0,-60])
    rotate([0,0,360*$t])
        linear_extrude(100, center=true, 10, twist=15) {
            offset(r=-tolerance) rootsrotor(3,60,1);
        }

    translate([0,60])
    rotate([0,0,-360*$t])
        linear_extrude(100, center=true, 10, twist=-15) {
            offset(r=-tolerance) rootsrotor(3,60,1);
        }
}