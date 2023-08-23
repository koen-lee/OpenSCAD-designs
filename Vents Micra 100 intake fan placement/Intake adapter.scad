
height=52;
 
module fan() {
    color("gray")
    difference() 
    {
        union() {
            translate([0,0,10])
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
                translate([0,0,8])
                linear_extrude(height-8, convexity=10) {
                    polygon([[50, 0],
                             [52, 0],
                             [57, -4],
                             [60,-10],
                             [55, -4]]);
                }
            }
            translate([0,0,-1])
            linear_extrude(1)
            {
                offset(r=-5)
                {
                    circle(d=130+10);                                
                    for(rot=[0:90:360]){
                        rotate(rot)
                        translate([65,0])
                            circle(d=10+10);
                    }
                }
            }
        }
        for(rot=[0:90:360]){
            rotate([0,0,rot]){
                translate([20.2,20.2,-1])
                    cylinder(d1=3, d2=2,h=5);
                    
                translate([65,0,-2])
                    cylinder(d1=4, d2=2,h=5);
            }
        }
    }
}


module strut_profile(){
    fudge = 5;
    polygon([[64+fudge, 0],
             [67+fudge, -3],
             [66+fudge, 4],
             [62+fudge,8]]);
}

module fan_mount1() {   
    $fn=64;
    h=22;
    // Zigzag
    for(rot=[0:90:360]){
        rotate([0,0,rot])
        {
            linear_extrude(h, twist=18)
                strut_profile();
        
            rotate([0,0,15])
            linear_extrude(h, twist=-18)
                strut_profile();
            
            linear_extrude(2)
            {
                difference(){
                    hull(){            
                        strut_profile();
                        rotate( 15 )            
                            strut_profile();
                        rotate( 11 )      
                            translate([65,0])
                                circle(d=7);
                    }                                    
                    rotate( 11 )      
                        translate([65,0])
                            circle(d=3);
                }
            }
        }   
    }
    
    
    // Mounting ring
    translate([0,0,h])
    {    
        difference() {
            cylinder(h=1.5, d=145 , center=true); 
            cylinder(h=5, d=135, center=true );
                    
            for(rot=[0:90:360]){
                rotate([0,0,rot+56])
                    translate([70,0,0])
                    scale([1,4,1])
                    cylinder(d=2,h=2, center=true);
                    
            }
        }
    }    
}

module fan_mount2() {   
$fn=64;
    h=32;
    translate([0,0,25]) {
        
        // Zigzag
        for(rot=[45:90:360]){
            rotate([0,0,rot-5])
            linear_extrude(h, twist=25)
                strut_profile();
            rotate([0,0,rot+20])
            linear_extrude(h, twist=-25)
                strut_profile();
        }
        // Mounting ring 
        difference() {
            cylinder(h=1.5, d=145 , center=true); 
            cylinder(h=5, d=135, center=true );
                    
            for(rot=[0:90:360]){
                rotate([0,0,rot+56])
                    translate([70,0,0])
                    scale([1,4,1])
                    cylinder(d=2,h=2, center=true);
                    
            }
        }
        
        // Intake ring 
        
        for(rot=[0:90:360])
        rotate([0,0,rot])
        translate([0,0,h]) {
            
            linear_extrude(2)
            {
                difference(){
                    hull(){            
                        strut_profile();
                        rotate( 15 )            
                            strut_profile();
                        rotate( 11 )      
                            translate([65,0])
                                circle(d=7);
                    }                                    
                    rotate( 11 )      
                        translate([65,0])
                            circle(d=3);
                }
            }
        }
    }
}

module intake_adapter() {
    $fn=64;
        
    offset = [10,10,35];
    translate([0,0,61.1]) {
     // Intake ring         
        intersection(){
            difference() {
                cylinder(h=1, d=140);
                cylinder(h=5, d=100, center=true );
                        
                for(rot=[0:90:360]){
                    rotate([0,0,rot])
                        translate([65,0,0]) 
                        cylinder(d1=4, d2= 4,h=3, center=true);               
                }
            }
            rotate([0,0,45])cube([111,111,120], center=true);
        }
        // Square-circle adapter
        z = [0,0,1];
        difference() {
            hull() {
                
                translate([0,0,1])
                cylinder(h=0.1, d=102);
                translate(offset)
                    cube([98,98,0.1], center=true);
            }            
            
            hull() {
                translate([0,0,0.99])
                    cylinder(h=0.1, d=100);
                translate(offset+0.01*z)
                    cube([93,93,0.2], center=true);
            }
        }
        
        difference() { 
            translate(offset+2*z)
                cube([95.8,95.8,4], center=true); 
            translate(offset)
                cube([93,93,10], center=true);        
        }
        translate([-48,0,2.5]+offset)
            rotate([0,45,0])
                cube([3,94,1.5], center=true);
        
        translate([47.5,0,2]+offset)
            rotate([0,-20,0]) cube([1,20,3], center=true);
        translate([0,47.50,2]+offset)
            rotate([0,-20,90]) cube([1,20,3], center=true);
        translate([0,-47.5,2]+offset)
            rotate([0,-20,-90]) cube([1,20,3], center=true);
    }

}

if( $preview )
{    
    fan();        
    color("lightblue")
      intake_adapter();
    rotate([0,0,-11]){
        fan_mount1();
        fan_mount2();
    }
} else {
   // intake_adapter();
 
   // rotate([180,0]) fan_mount1();
    fan_mount2();
}