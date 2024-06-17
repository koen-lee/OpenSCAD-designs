$fn=32;
difference(){
    union(){
        cylinder(d1=21, d2=24, h=1.7);
        cylinder(d1=16, d2=15, h=4);
        cylinder(d=5.5, h=5);
    }
    translate([0,0,-0.01])
        cylinder(d = 7, h=1.72);
    translate([0,0,1.7])
        cylinder(d1 = 7, d2=2.5, h=2);
    cylinder(d=2.8, h=20);
    if($preview) cube(20);
}
