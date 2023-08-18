
height=80;
 
module fan() {
    color("gray")
    difference() 
    {
        union() {
            translate([0,0,2])
                cylinder(h=1, d=125);
            cylinder(h=height-3, d=80);
            translate([0,0,height-3])
                cylinder(h=3, d1=80, d2=40);
            difference() {
                translate([0,0,height-2])
                    cylinder(h=1, d=125 );
                translate([0,0,height-4])
                    cylinder(h=5, d=105 );
            }
            for(rot=[0:12:360]){
                rotate([0,0,rot])
                linear_extrude(height, convexity=10) {
                    polygon([[50, 0],
                             [52, 0],
                             [57, -4],
                             [60,-10],
                             [55, -4]]);
                }
            }
        }
        for(rot=[0:90:360]){
            rotate([0,0,rot])
            translate([20.2,20.2,-1])
                cylinder(d1=3, d2=2,h=5);
        }
    }
}
if( $preview )
    fan();


