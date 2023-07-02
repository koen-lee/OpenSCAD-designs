// diameter guide = 24.8mm
// diameter drill = 48 mm

module ring(inner_d, thickness, height)
{
    difference() {
        cylinder(d = inner_d+thickness, h = height, center=true);
        cylinder(d = inner_d, h = height+1, center = true);
    }
}

z = [0,0,1];

module drill_matcher() {
    intersection()
    {
        translate([-20,0,0])
            cube([40,90,81]);
        difference(){
            cylinder(d=90, h=90);
            cylinder(d=48, h=42, center=true);
                translate([0,24,20])
                    cube([5,7,10], center=true);
            translate([0,-16+5.5,20])
            {
                cylinder(d=80, h=90);
                translate([0,0,43])
                {
                    cylinder(d1=80, d2 = 83, h=1.1);
                    translate(z)
                    {
                        cylinder(d=83, h=12.1);                        
                        translate(z*12)
                        {
                            cylinder(d1 = 83, d2=80, h=1);
                        }
                    }
                }
            }
            translate(z*10)
                ring(58, 3, 7);
            translate(z*63)
                ring(70, 3, 7);
        }
    }
}

difference(){
    union(){
        color("blue") drill_matcher();
         translate([-10,40,0])
            cube([20,30,81]);
    }
    translate(z*10) rotate([-90,0,0]) cylinder(d=8.5, h=100);
    translate(z*70) rotate([-90,0,0]) cylinder(d=8.5, h=100);
    translate([0,55,10]) rotate([-90,0,0]) {
        cylinder(d=14.6, h=6, $fn=6);
        translate([50,0,3])cube([100,12.9,6],center=true);
    }
        translate([0,55,70]) rotate([-90,0,0]) {
        cylinder(d=14.6, h=6, $fn=6);
        translate([50,0,3])cube([100,12.9,6],center=true);
    }
}

