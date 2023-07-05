// diameter guide = 24.8mm
// diameter drill = 48 mm
$fn=64;

z = [0,0,1];

module version_(){
    linear_extrude(2, center=true)
        text("2", size=6,halign="center", valign="center");
}

module ring(inner_d, thickness, height)
{
    difference() {
        cylinder(d = inner_d+thickness, h = height, center=true);
        cylinder(d = inner_d, h = height+1, center = true);
    }
}

module material_saver_half()
{
    translate([0.5,-15,-15])
    hull()    {
        translate([20,0,-20])
        cube([20,30,70]);
        cube([20,30,30]); 
    }
}
module material_saver()
{
    material_saver_half();
    mirror([1,0,0])
        material_saver_half();
}

module drill_matcher() {
    intersection()
    {
        translate([-20,0,0])
            cube([40,90,80]);
        difference(){
            cylinder(d=90, h=90);
            cylinder(d=48, h=52, center=true);
                translate([0,24,21])
                    cube([5,7,10], center=true);
            translate([0,-16+5.5,24])
            {
                cylinder(d=80, h=90);
                translate([0,0,39])
                {
                    cylinder(d1=80, d2=83, h=1.1);
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
            translate(z*60)
                ring(70, 3, 7);
        }
    }
}

module drill_part() {
    color("blue") 
    difference(){
        union(){
            drill_matcher();
             translate([-10,40,0])
                cube([20,30,80]);
        }
        translate(z*10) rotate([-90,0,0]) cylinder(d=8.5, h=100);
        translate(z*70) rotate([-90,0,0]) cylinder(d=8.5, h=100);
        translate([0,55,10]) rotate([-90,0,0]) {
            cylinder(d=15, h=6.3, $fn=6.3);
            translate([50,0,3])cube([100,13.3,6.3],center=true);
        }
        translate([0,55,70]) rotate([-90,0,0]) {
            cylinder(d=15, h=6.3, $fn=6);
            translate([50,0,3])cube([100,13.3,6.3],center=true);
        }
    
        translate(z*20)
            ring(90, 3, 7);
        translate(z*60)
            ring(90, 3, 7);
        translate([0,50,40])
            material_saver();
        
        translate([0,50,80]) version_();
    }
}

module guide_part() {
    difference()
    {
        union(){
            cylinder(d=40,h=80);
             translate([-10,15,0])
                cube([20,10,80]);
        }
        cylinder(d=25.3,h=180, center=true);
        cube([30,15,180], center=true);
        cube([15,30,180], center=true);
        translate(z*0)  cylinder(d1=30, d2=25, h=6, center=true);
        translate(z*80) cylinder(d1=25, d2=30, h=6, center=true);
        
        translate(z*10) rotate([90,0,0]) cylinder(d=8.5, h=100, center=true);
        translate(z*70) rotate([90,0,0]) cylinder(d=8.5, h=100, center=true);
        translate(z*10) rotate([90,0,0]) translate(-z*20)cylinder(d=16, h=100);
        translate(z*70) rotate([90,0,0]) translate(-z*20)cylinder(d=16, h=100);
        
        translate(z*40)rotate([45,0]) cube([80,20,20], center=true);
        
        translate([0,20,80]) rotate([0,0,180]) version_();
    }
}


drill_part();
translate([0,-5,0])
guide_part();

