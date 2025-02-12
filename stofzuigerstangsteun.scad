$fn=128;

module cut() {
   difference() 
    {
        hull()
        {
            circle(d=32+4);
            translate([46,0]) scale([0.2,1])
                circle(d=34);
        } 
        circle(d=32+4.01);
    }
}

module half_steun() {
    difference() {
        translate([0,0,0.005])
            union() {
            linear_extrude(15, convexity=10)
            {
                cut();
            }
            hull() {
                linear_extrude(5, convexity=10)
                {
                    offset(2)
                    cut();
                }
                
                linear_extrude(10, convexity=10)
                {
                    cut();
                }
            }
        }

        hull(){
            linear_extrude(0.01) {
                    translate([38,0])
                    offset(r=2+2) offset(r=-2)
                        square([18,32], center=true);
            }
            linear_extrude(2) {
                    translate([38,0])
                    offset(r=2) offset(r=-2)
                        square([18,32], center=true);
            }
        }

        linear_extrude(30) {
                translate([38,0])
                offset(r=2) offset(r=-2)
                    square([18,32], center=true);
            
        circle(d=32+4.01);
        }
    }
}

translate([0,0,-15])
half_steun();
mirror([0,0,01])

translate([0,0,-15])
half_steun();