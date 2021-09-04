use <threadlib/threadlib.scad>;
$fn=64;
module pipe_end() {
    cylinder(d=22.7, h=70);
    translate([0,0,40])
    cylinder(d1=22.7, d2=24, h=1);
    translate([0,0,41])
    cylinder(d=40, h=30);
}
module pipes() {
    color("gray") {
        translate([0,15,0])
        rotate([-90,0,0]) 
            pipe_end();
        translate([15,0,0])
        rotate([0,90,0])
            pipe_end();
        translate([0,0,-27.1/2]) {
            if($preview) {
                cylinder(d=16, h=29);
            } else {
                tap("M16", turns=15);
            }                
            translate([0,0,-10])
                cylinder(d=17, h=10.1);
        }
        translate([0,0,5])
        difference(){
            cylinder(d=25, h=70);
            cylinder(d=21, h=10, center=true);
        }
        translate([0,0,54])
        cylinder(d1=25, d2=27, h=1);
        translate([0,0,55])
        cylinder(d=40, h=30);
    }
}

module corner() {
    difference() {
        union()
        {
            translate([0,0,0])
            rotate([-90,0,0]) {
                cylinder(d=27, h=70);
                sphere(d=27);
            }
            translate([0,0,0])
            rotate([0,90,0])
                cylinder(d=27, h=70);
            cylinder(d=29, h=70);
            sphere(d=29);
            cylinder(d=25, h=27, center=true);
            hull()
            {
                cube(2, center=true);
                translate([70,0,0])
                    cube(2, center=true);
                translate([0,0,70])
                    cube(2, center=true);
            }
            hull()
            {
                cube(2, center=true);
                translate([0,70,0])
                    cube(2, center=true);
                translate([0,0,70])
                    cube(2, center=true);
            }
            hull()
            {
                cube(2, center=true);
                translate([0,70,0])
                    cube(2, center=true);
                translate([70,0,0])
                    cube(2, center=true);
            }
            
            hull()
            {
                translate([0,0,28])
                    cube(2, center=true);
                translate([0,28,0])
                    cube(2, center=true);
                translate([28,0,0])
                    cube(2, center=true);
            }
        }
        pipes();
    }
}

corner();