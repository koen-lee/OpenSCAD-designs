module nicebox(size)
{
    hull() {
        translate([0,0.5,0.5])
        cube(size - [0,1,1]);
        translate([0.5,0.5,0])
        cube(size - [1,1,0]);
        
        translate([0.5,0,0.5])
        cube(size - [1,0,1]);
    }
}


nicebox([90,80,2]);

translate([35,65,0])
    nicebox([20,20,2]);

difference() {
    union(){
        translate([0,3,0])
            nicebox([2,8,7]);
        translate([88,3,0])
            nicebox([2,8,7]);
    }
    translate([45,7,4])
    rotate([0,90,0])
        cylinder(d=1.8, h=200, center=true, $fn=10);
}


difference() {
    union(){
        translate([34,3,0])
            nicebox([2,4,6]);
        translate([44,7,0])
            nicebox([2,4,6]);
        translate([54,3,0])
            nicebox([2,4,6]);
    }
    translate([45,7,4])
    rotate([0,90,0])
        cylinder(d=1.6, h=200, center=true, $fn=10);
}