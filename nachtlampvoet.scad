module lamp() {
    translate([0,-190/sqrt(3),3]) {
        th = 17;
        rotate([-th,0,0])
            cylinder(d=20, h=370);
        rotate([0,0,-30])
            translate([0,190,0])
                rotate([0,0,-30])
                rotate([th,0,0])
                cylinder(d=20, h=370);
        rotate([0,0,30])
            translate([0,190,0])
                rotate([0,0,30])
                rotate([th,0,0])
                cylinder(d=20, h=370);
    }
    translate([0,0,230])
        cylinder(d=50, h=100);
    translate([0,0,330])
        color("gray")
            cylinder(d1=350, d2 = 300, h=200);
}

color("lightblue")
{
    difference() {
        union() {
            translate([-190/2,0])
                cylinder(d=18,h=7);
            hull() {
                translate([-190/2,0])
                    cylinder(d=18,h=1);
                translate([190/2,0])
                    cylinder(d=18,h=1);
            }
            translate([190/2,0])
                cylinder(d=18,h=7);
        }
        
                translate([-190/2,0,-0.1])
                    cylinder(d1=9, d2=1,h=4);
                translate([190/2,0,-0.1])
                    cylinder(d1=9, d2=1,h=4);

        translate([0,-190/2/sqrt(3)])
            lamp();
    }
}

        translate([0,-190/2/sqrt(3)])
            lamp();