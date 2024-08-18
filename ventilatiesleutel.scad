inner_to_outer_ratio = (sqrt(3)/2);
difference() {
    union(){
        cylinder(d=9.8/inner_to_outer_ratio, h=25, center=true, $fn=6);
        translate([0,0,6.25]) cube([14,1.5,12.5], center=true);
    }
    
    hex_minor = 6.1;
    rotate([90,30,0])
        cylinder(h=20,d=hex_minor/inner_to_outer_ratio, center=true, $fn=6);
    cylinder(h=26,d=hex_minor/inner_to_outer_ratio, center=true, $fn=6);
}