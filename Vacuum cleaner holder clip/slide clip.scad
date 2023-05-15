$fn=64;
slot_thickness=3;
slot_width=17;
module clip() {
    difference() {
        union(){
            hull() {
                cylinder(h=slot_thickness-1, d=slot_width-1, center=true);
                cylinder(h=slot_thickness, d=slot_width-2, center=true);
                translate([40-4,0])
                    cube([8,slot_width,slot_thickness-1], center=true);
                translate([40-4,0])
                    cube([8,slot_width-1,slot_thickness], center=true);
            }
            hull() {
                translate([22,0,5])
                    cube([36,8,10], center=true);

                translate([-2,0,5])
                cylinder(h=10, d=8, center=true);
            }

            hull() {
                translate([22,0,2])
                    cube([36,8,1], center=true);
                translate([22,0,1])
                    cube([36,9,1], center=true);
                translate([-2,0,2])
                    cylinder(h=1, d=8, center=true);
                translate([-2,0,1])
                    cylinder(h=1, d=9, center=true);
            }
            hull() {
                off=5.1;
                translate([22,0,off])
                    cube([36,8,1], center=true);
                translate([22,0,off+1])
                    cube([36,10,1], center=true);
                translate([-2,0,off])
                    cylinder(h=1, d=8, center=true);
                translate([-2,0,off+1])
                    cylinder(h=1, d=10, center=true);
            }
        }
        translate([-8.6,0])
        linear_extrude(10, center=true) {
            polygon([
                [0,-3],
                [2,-1.5],
                [10,-1.5],
                [10,1.5],
                [2,1.5],
                [0,3]
            ]);
        }
    }
}

module tiewrapslot() {
    rotate_extrude()
    {
        translate([21,0])
            polygon([
                [1,0],
                [2,1],
                [2,5],        
                [1,6],
                [0,5],
                [0,1],
            ]); 
    }
}
intersection(){
    translate([-30,0,0])
    cylinder(h=100, d=50, center=true);
difference(){
    union() {
    translate([-20,0,0]){
        translate([-7,0,40])
            rotate([0,90,0])
                clip();
        }
        cylinder(h=50, d=44);
    }
    cylinder(h=150, d=40, center=true);
    translate([0,0,35])
    rotate([0,90,0])
        cylinder(h=150, d=4, center=true);
    
    translate([0,0,13])
    rotate([0,90,0])
    cylinder(h=150, d=4, center=true);
    
    translate([-0,0,3])
        tiewrapslot();
    translate([-0,0,25])
        tiewrapslot();
}
}