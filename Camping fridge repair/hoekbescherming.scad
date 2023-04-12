module leg(hole)
difference() {
    f = 30/-sqrt(3);
    scale([1,1.2,1])
    translate([-f,-f,-f])
    intersection() {
        difference() {
            sphere(30, $fn=150);
            translate([f,f,f])
                cube(60);
        }
        cube(46, center=true);
    }
    translate(hole) {
        cylinder(d=4, h=100, center=true);
        translate([0,0,-102])
            cylinder(d2=10, d1=10, h=100, center=false);
        
        translate([0,0,-104])
            cylinder(d2=10, d1=110, h=100, center=false);
    }
}

leg([17,36]);

translate([90,0])
mirror([1,0,0])
leg([17,36]);


translate([90,100])
mirror([0,1])
mirror([1,0])
leg([17,22]);

translate([000,100])
mirror([0,1,0])
leg([17,22]);


