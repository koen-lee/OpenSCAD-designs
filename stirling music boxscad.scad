use <MCAD\involute_gears.scad>;
$fn=32;
z=[0,0,1];

module mygear( n, bore )
{
        union(){
            gear(number_of_teeth = n, circular_pitch = 500, bore_diameter = bore, hub_thickness=3, rim_thickness=4, rim_width = 20, twist=10*8/n);
            translate(z*4)
            rotate(z*-10*8/n)
            gear(number_of_teeth = n, circular_pitch = 500, bore_diameter = bore, hub_thickness=3, rim_thickness=4, rim_width = 20, twist=-10*8/n);
        }
}

module drive_gear() {
    difference(){
        union()
        {
            mygear(7,10);
            cylinder(h=8, d=6);
            translate(z*4)
            cube([3,10,8],center=true);
            
        }
        cylinder(h=100, d=3.5, center=true);
        cube([1,10,100],center=true);
        
    }
    translate([7,0,7.9])
       cylinder(h=3, d=2, $fn=8);
}


module driven_gear() {
    difference() {
        union() {
            difference(){ 
                mygear(60,140); 
                translate(z)
                    cylinder(h=100, d=155);        
            }            
            translate(z*4)
                cube([10,156,8],center=true);
            translate(z*12)
                cube([10,30,8],center=true);
        }
        cylinder(h=100, d=3.5, center=true);
        cube([1,140,100],center=true);
        
            translate(z*13)
                cube([11,10,10],center=true);
            translate(z*13)
                cube([3.5,31,10],center=true);
    }
}

module distance_holder() {
    dist = -93.2;
    difference()
    {
        union() {
            hull(){
                cylinder(d=8, h=1);
                translate([dist,0,0])
                    cylinder(d=8, h=1);
            }
            cylinder(d=5, h=1.5, center=true);
            translate([dist,0,0])
                cylinder(d=5, h=1.5, center=true);

        }
        cylinder(d=3.5, h=4, center=true);
        translate([0,4])
            cube([3.5, 8, 4], center=true);
        translate([dist,0,0])
            cylinder(d=3.5, h=4, center=true);
        translate([dist,4,0])
            cube([3.5, 8, 4], center=true);
        
    }
}
if($preview) {
    translate([-93.2,0,0])
        mirror([1,0,0])
            rotate(z*360*$t*(60/7))
                drive_gear();
    rotate(z*360*$t)
    color("green")
    driven_gear();
    color("magenta")
    translate(z*-1.5)
        distance_holder();
} else {
    
    translate([20,0,0])
        mirror([1,0,0])
            drive_gear();
        driven_gear();
    translate([-15,45])
        rotate(z*90)
            distance_holder();

    translate([-25,45])
        rotate(z*90)
            distance_holder();
}