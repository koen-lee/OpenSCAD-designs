use <threadlib/threadlib.scad>;
$fn=64;
module pipe_end() {
    cylinder(d=23.1, h=70);
    translate([0,0,40])
    cylinder(d1=23.1, d2=24, h=1);
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
            
            translate([0,0,6])
            scale([1.1, 1.1, 1])
            if($preview) {
                cylinder(d=15, h=20);
            } else {
                tap("M16", turns=15);
            }                
            translate([0,0,-3])
                cylinder(d=17.5, h=10.1);
        }
        translate([0,0,5])
        difference(){
            cylinder(d=26, h=70);
            cylinder(d=21, h=10, center=true);
        }
        translate([0,0,54])
        cylinder(d1=26, d2=27, h=1);
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