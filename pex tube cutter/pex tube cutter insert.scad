$fn=64;
difference(){
    union(){
        
        cylinder(d=35, h=20, center=true);
        hull()
        {
            cylinder(d=8, h=20, center=true);
            translate([32,-2,0])
                cylinder(d=4, h=20, center=true);
        }
    }
    cylinder(d=25, h=21, center=true);
    cube([55,55,3], center=true);
    translate([0,17,0])
        cube([80,32,21], center=true);
}