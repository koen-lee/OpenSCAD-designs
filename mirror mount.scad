$fn=32;
h=8;
mirror_thickness = 3.1;
difference(){
    hull(){
        cylinder(h=h-1,d=10);
        cylinder(h=h,d=8);
        translate([6,0])
        {
            cylinder(h=h-1,d=10);
            cylinder(h=h,d=8);
        }
    }
    cylinder(d=4,h=100,center=true);
    translate([0,0,h-1.5])
        cylinder(d1=4,d2=8,h=2);
    hull() {
        translate([4,-10,-0.01])
            cube([20,20,mirror_thickness]);
        
        translate([4-0.5,-10,-0.5])
            cube([20,20,mirror_thickness]);
    }
}