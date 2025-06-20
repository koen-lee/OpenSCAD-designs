module holes(){
        circle(d=3);
        translate([0,25])
        circle(d=3);
        translate([25,25/2])
        circle(d=17.5);
}
$fn=64;
difference(){
    union()
    {
        linear_extrude(3) {
            offset(r=5)
            hull(){
                holes();
            }
        }
        translate([25,25/2])
        hull() {
            cylinder(d=17.5+10, h=3);
            cylinder(d=17+2, h=13);
        }
    }
   linear_extrude(30, center=true) {
       holes();
   }
}