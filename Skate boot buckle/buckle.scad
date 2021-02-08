$fn=128;
module buckle(){
    intersection()
    {
        union() {
            cylinder(r=4.5, h=20);
            translate([0,-4.5,0])
                cube([28,9,20]);
            translate([27.9,-9.5,0])
                cube([28,19,20]);
        }
        
        translate([0,0,-85])
        rotate([90,0,0])
        difference(){
            cylinder(r=100, h=40, center=true);
            translate([0,-10,0])            
                cylinder(r=100, h=41, center=true);
            translate([6,95,0])
            rotate([45,0,0]){
                cylinder(r=1.4, h=41, center=true);
                translate([10,0,0])
                    cube([20,2.8,41],center=true);
            }
            
        }
    }
}


buckle();