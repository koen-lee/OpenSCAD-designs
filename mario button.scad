difference()
{
    
    translate([0,0,2])
    rotate([0,3])
    scale([1,1,0.3])
        sphere(d=30, $fn=64);
    
    hull(){
        translate([0,0,1])
        cylinder(d=17.5, h=1);
        cylinder(d=15.5, h=3);
        translate([30,0])
        cylinder(d=17.5, h=3);
    }
    hull(){
        cylinder(d=7, h=20);
        translate([30,0])
        cylinder(d=7, h=20);
    }
    cylinder(d=17.5, h=5);
}