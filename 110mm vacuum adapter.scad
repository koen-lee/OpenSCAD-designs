$fn=128;
difference() {
    union()
    {
        hull() {
            cylinder(h=30, d1=133, d2=115);
            translate([70,0,0]){
                rotate([0,40,0]){
                    translate([-4,0,17])cylinder(d=48, h=1);
                }
            }
        }
        translate([70,0,0]){
            rotate([0,40,0]){
                translate([-4,0,17]){
                    cylinder(d=48, h=14);
                }         
            }
        }
    }
    translate([0,0,-3])
        cylinder(h=35, d1=120, d2=111);
    hull() {
        translate([0,0,1])
            cylinder(h=29, d1=130, d2=111);
        translate([70,0,0]){
            rotate([0,40,0]){
                translate([-4,0,16])cylinder(d=45, h=1);
            }
        }
    }
    translate([70,0,0]){
        rotate([0,40,0]){
            translate([-4,0,16]){
                cylinder(d=45, h=16);
                translate([0,0,9])
                    cube([16, 60, 4], center=true);
            }         
        }
    }
}

