
module kierhouder(){
  linear_extrude(50, center=true, convexity=4, $fn=64)
    import("kierhouder.svg");
}

module screw() {
    cylinder(h=11,r=2);
    translate([0,0,10])
        cylinder(h=4,d1=3, d2= 10);
    translate([0,0,13.9])
        cylinder(h=20,d=10);
}

difference()
{
    kierhouder();
    color("blue"){
        translate([-10,11,15])
            rotate([0,90,0])
                screw();
        translate([-10,11,-15])
            rotate([0,90,0])
                screw();
    }
}