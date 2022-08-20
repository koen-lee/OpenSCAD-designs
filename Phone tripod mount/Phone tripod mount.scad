use <threadlib/threadlib.scad>;
$fn=32;
 
module under_part() {
    color("gray")
    difference(){ 
        cylinder(h=70, d=30);
        
        tap("UNF-1/4", turns=8);
        translate([0,3,8])
            scale([40,20,2])
                rotate([0,90,0])
                    cylinder(d=1,h=1,center=true);
        translate([0,13,8+50])
            cube([40,40,100], center=true);
        translate([0,-10,8])
        linear_extrude(70)
        {
            polygon([[-9,0],[9,0],[0,9]]);
        }
        
        translate([0,-10,0])
        rotate([0,90,0])
            cylinder(d=4,h=40,center=true);
    } 
}

module upper_part()
{
    intersection(){
        cube([100,100,16]);
        translate([0,0,-0.5])
        difference(){
            union() {
                translate([0,0,8.5])
                rotate([0,90,0])
                linear_extrude(60)
                {
                    polygon([[-8.5,0],[8.5,0],[5,3.5],[-5,3.5]]);
                }
                cube([6,21,17]);            
                translate([3,21])
                    cylinder(h=17,d=6);
                
            }
            translate([1.4,4,-1])
                cylinder(h=25,d=3);
            
            translate([6,12,-1])
                scale([2,17,40])
                    cylinder(d=1,h=1,center=true);
        }
    }
}
 
under_part();
translate([-23,-20])
upper_part();