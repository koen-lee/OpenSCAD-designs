$fn=64;
difference()
{
    hull(){
        cylinder(d=15, h=4);
        cylinder(d=10, h=7);
    }
    translate([ 0,0,2])
        screw();
    
    hull() {
        translate([ 0, 0,2.3])
            screw();
        translate([ 0,30,2])
            screw();
    }
    hull() {
        translate([ 0,30,2])
            cylinder(d=4,h=20);
        translate([ 0, 0,2.3])
            cylinder(d=4,h=20);
    }
    cylinder(d=4,h=20, center=true);
    
    translate([0,3.5,5.5])
    rotate([0,90,0])
        cylinder(d=1, h=20, center=true);
}
module screw()
{    
    hull() {
        
        cylinder(d=9.4, h=0.7);
        translate([0,0,0.3])
            cylinder(d=10, h=0.7);
        cylinder(d= 4, h=4);
    }
}
