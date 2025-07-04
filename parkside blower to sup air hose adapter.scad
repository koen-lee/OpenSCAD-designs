$fn=64;

parkside_end();
translate([0,0,25])
rotate([0,0,90])
sup_end();

module sup_end() {
    difference(){
        linear_extrude(8, twist=360, convexity=10)
        {
            difference(){
                union(){
                    intersection()
                    {
                        circle(d=30);
                        square([40,17],center=true);
                    }
                    circle(d=26);
                }
                circle(d=22);
            }
        }
        translate([0,0,-0.01])
        difference(){
            union(){
                cube([100,100,1]);
                rotate([0,0,180])
                cube([100,100,1]);
            }
            cylinder(d=26, h=10);
        }
        translate([0,0,8-0.99])
        rotate([0,0,90])
        difference(){
            union(){
                cube([100,100,1]);
                rotate([0,0,180])
                cube([100,100,1]);
            }
            cylinder(d=26, h=10);
        }
        translate([0,0,-0.01])
        cylinder(h=8,d1=24,d2=22);
    }
}


module parkside_end(){
    lock_diameter=29;
    difference(){
        union() {
            cylinder(h=10, d=31);
            cylinder(h=25, d=26);
            translate([0,0,10])
            cylinder(h=4, d1=31, d2=26);
        }
        cylinder(h=250, d=24, center=true);
        hull()
        {
            translate([0,0,6])
            {
                rotate([90,0,0])
                    cylinder(h=lock_diameter/2, d=4 );
                rotate([90,0,20])
                    cylinder(h=lock_diameter/2, d=4);
            }
        }
        hull()
        {
            rotate([0,0,180])
            translate([0,0,6])
            {
                rotate([90,0,0])
                    cylinder(h=lock_diameter/2, d=4 );
                rotate([90,0,20])
                    cylinder(h=lock_diameter/2, d=4 );
            }
        }
        
        hull()
        {
            translate([0,0,6])
                rotate([90,0,0])
                    cylinder(h=lock_diameter, d=4, center=true );
            translate([0,0,-6])
                rotate([90,0,0])
                    cylinder(h=lock_diameter, d=4, center=true );
            
        }
    }
}