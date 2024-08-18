$fn= 32;

module adapter( outer_d, spigot_l, slot_w, slot_h, slot_l=0, extralength = 0 )
{
    translate([0,0,-extralength/2])
        cylinder(d1=outer_d-1, d2=outer_d, h=spigot_l+0.5*extralength);
    translate([0,0,spigot_l])
    hull(){
        cylinder(d=outer_d, h=0.1, center=true);
        intersection() {
            cylinder(d1=outer_d, d2=slot_h, h=slot_w/2);
            translate([0,slot_h/2])
                cube(slot_h, center=true);
        }
        intersection(){
            scale([1,outer_d,2*(slot_w)])
            rotate([0,90,0])
                cylinder(d=1, h=0.1);
            translate([0,-outer_d,0])
                cube(outer_d);
        }
        translate([0,extralength/2,slot_w/2+extralength])
        scale([slot_h, 0.1, slot_w])
            rotate([-90,0,0])
                cylinder(d=1, h=1);
    }
    
    translate([0,0,spigot_l+extralength])
        translate([0,extralength/2, slot_w/2])
            scale([slot_h, outer_d/2 + extralength+slot_l, slot_w])
            rotate([-90,0,0])
                cylinder(d=1, h=1);
     
}
if($preview) {
    translate([0,34.75,-35])
    rotate([90,0])
     difference() {
        adapter(35.5, 30, 9.5, 35, 10 );
        adapter(33.0, 30, 7.5, 33, 10, 1);
    }

    ///*/
    translate([0,0,50])

    translate([0,-31,20])
    rotate([270,0])
    difference() {
        adapter(40, 25, 12, 38,1);
        adapter(37.5, 25, 10, 36,1, 1);
    }
}

scale([35,9.5])
cylinder(h=40, d=1);

hull() {
scale([40,12])
cylinder(h=5, d=1);
scale([35,9.5])
cylinder(h=10, d=1);

}
