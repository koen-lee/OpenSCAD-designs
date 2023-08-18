
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

module fan_mount1() {   
    $fn=64;
    // Fan connection    
    difference() {
        cylinder(d=130, h=2);
        for(rot=[0:90:360]){
            rotate([0,0,rot]){
                translate([20.2,20.2,-1])
                    cylinder(d=3.5,h=5, $fn=32);
                //material saver                
                translate([0,0,-1.5])
                    cylinder(d=32,h=2, $fn=32);
                translate([40,0,-1.5])
                    cylinder(d=45,h=2, $fn=32);
                
                translate([36,36,-1.5])
                    cylinder(d=20,h=2, $fn=32);
            }
        }
    }
    // Zigzag
    for(rot=[0:90:360]){
        rotate([0,0,rot])
        linear_extrude(40, twist=30)
                polygon([[65, 0],
                         [67, 4],
                         [63,8]]);
    }    
    for(rot=[0:90:360]){
        rotate([0,0,rot+15])
        linear_extrude(40, twist=-30)
                polygon([[65, 0],
                         [67, 4],
                         [63,8]]);
    }
    // Mounting ring
    translate([0,0,40])
    {    
        difference() {
            cylinder(h=1, d=135 , center=true); 
            cylinder(h=5, d=125, center=true );
                    
            for(rot=[0:90:360]){
                rotate([0,0,rot+56])
                    translate([65,0,0])
                    scale([1,3,1])
                    cylinder(d=1.5,h=2, center=true);
                    
            }
        }
    }    
}

module fan_mount2() {   
$fn=64;
    translate([0,0,43]) {
        
        // Zigzag
        for(rot=[45:90:360]){
            rotate([0,0,rot])
            linear_extrude(40, twist=30)
                    polygon([[65, 0],
                             [67, 4],
                             [63,8]]);
        }    
        for(rot=[45:90:360]){
            rotate([0,0,rot+15])
            linear_extrude(40, twist=-30)
                    polygon([[65, 0],
                             [67, 4],
                             [63,8]]);
        }
        // Mounting ring 
        difference() {
            cylinder(h=1, d=135 , center=true); 
            cylinder(h=5, d=125, center=true );
                    
            for(rot=[0:90:360]){
                rotate([0,0,rot+56])
                    translate([65,0,0])
                    scale([1,3,1])
                    cylinder(d=1.5,h=2, center=true);
                    
            }
        }
        
        // Intake ring         
        translate([0,0,41]) {
            difference() {
                cylinder(h=2, d=135 , center=true); 
                cylinder(h=5, d=100, center=true );
                        
                for(rot=[0:90:360]){
                    rotate([0,0,rot+11])
                        translate([60,0,0]) 
                        cylinder(d1=6, d2= 4,h=3, center=true);
                        
                }
            }
        }
    }
}

module intake_adapter() {
    $fn=64;
        
    translate([0,0,85]) {
     // Intake ring         
        intersection(){
            difference() {
                cylinder(h=1, d=135);
                cylinder(h=5, d=100, center=true );
                        
                for(rot=[0:90:360]){
                    rotate([0,0,rot])
                        translate([60,0,0]) 
                        cylinder(d1=4, d2= 4,h=3, center=true);               
                }
            }
            rotate([0,0,45])cube([111,111,120], center=true);
        }
        // Square-circle adapter
        offset = [0,0,20];
        z = [0,0,1];
        difference() {
            hull() {
                
                translate([0,0,1])
                cylinder(h=1, d=102);
                translate(offset)
                    cube([98,98,1], center=true);
            }            
            
            hull() {
                translate([0,0,0.99])
                    cylinder(h=1, d=100);
                translate(offset+0.1*z)
                    cube([93,93,6], center=true);
            }
        }
        
        difference() { 
            translate(offset+2*z)
                cube([95.8,95.8,4], center=true); 
            translate(offset)
                cube([93,93,10], center=true);        
        }
    }
    translate([-48,0,108])
        rotate([0,45,0])
            cube([3,94,1.5], center=true);

}

if( $preview )
{    translate([0,0, 2])
        fan();
}

color("lightblue")
intake_adapter();
rotate([0,0,-11]){
    fan_mount1();
    fan_mount2();
}