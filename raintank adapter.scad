$fn= 32;

module adapter( outer_d, slot_w, extralength =0 )
{
    translate([0,0,-extralength/2])
        cylinder(d1=outer_d-1, d2=outer_d, h=25+0.5*extralength);
    translate([0,0,25])
    hull(){
        cylinder(d=outer_d, h=0.1, center=true);
        intersection(){
            scale([1,outer_d,2*(slot_w)])
            rotate([0,90,0])
                cylinder(d=1, h=0.1);
            translate([0,-outer_d,0])
                cube(outer_d);
        }
        translate([-outer_d/2,extralength/2])
            cube([outer_d, 0.1, slot_w+extralength]);
    }
    
    translate([0,0,25+extralength])
        translate([-outer_d/2,extralength/2])
            cube([outer_d, outer_d/2 + extralength, slot_w]);
}

difference() {
    adapter(35, 10);
    adapter(33, 8,1);
}
translate([36,0,0])


difference() {
    adapter(28,7);
    adapter(26, 5,1);
}
