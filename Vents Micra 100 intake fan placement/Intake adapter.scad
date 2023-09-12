
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
            /*translate([0,0,-1])
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
            }*/
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

module space(){

    corner = 95.8/2;
    translate([20+10,0,15])
        translate([corner,0,0])
            cube([2,300,159], center=true);
    
    translate([0,18+10,15])
        translate([0,corner,0])
            cube([300,2,159], center=true);
    
    
    translate([-50+10,10,-80+15])
        translate([-corner,-corner,0])
            cylinder(h=160, r1=0, r2=1);
    
    translate([-90+10,-20+10,-80+15])
        translate([-corner,corner,0])
            cylinder(h=160, r1=0, r2=1);
    
    translate([-84,-46,10])
    rotate([0,0,28])
        cube([2,192,159], center=true);
}
module fan_mount1() 
{
    translate([0,0,-45])
    rotate([0,0,-180])
    linear_extrude(130, convexity=10)
        import("spiral.svg");
}
module fan_mount2(){
    h=45;
    rotate([0,0,-180])
    translate([0,0,-h])
    difference(){
        union(){
            linear_extrude(1, convexity=10)
                hull() import("spiral.svg");   
            linear_extrude(2, convexity=10)
                offset(1) import("spiral.svg");   
            cylinder(h=h, r1=65, r2=40);
        }
        translate([0,0,1])
        linear_extrude(2, convexity=10)
        
            offset(r=0.1)
            import("spiral.svg");
                            
        translate([0,0,-2])
            cylinder(h=h, r1=65-0.8, r2=40-0.8);
        
        // fan mounting holes
        for(rot=[0:90:360]){
            rotate([0,0,rot]){
                translate([20.2,20.2,h])
                    cylinder(d1=3.5, d2=3.5,h=5, center=true);
            }
        }
        // Cable hole
        translate([0,0,h]) rotate([0,0,45])
            cube(50, center=true);
    } 
}

module fan_mount3(){
    h=30;
    rotate([0,0,-180])
    translate([0,0,55+h])
    difference(){
        union(){            
            translate([0,0,1])
                linear_extrude(1, convexity=10)
                    hull() import("spiral.svg");  
            linear_extrude(2, convexity=10)
                offset(1) import("spiral.svg");    
            translate([0,0,-h])
            cylinder(h=h+2, r1=50, r2=65);
        }
        translate([0,0,-1])
        linear_extrude(2, convexity=10)
            offset(r=0.1)
                import("spiral.svg");
          
            translate([0,0,-h-0.5])
                cylinder(h=h+3, r1=50-1.5, r2=65-1.5);     
        
    } 
}

module intake_adapter() {
    $fn=64;
        
    offset = [10,10,35];
    translate([0,0,56]) {
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
  //  intake_adapter();
  //  space();
    fan_mount1();
    fan_mount2();
    color("orange")
    fan_mount3();
} else {
   //intake_adapter();
 
    fan_mount1();
    translate([200,0]) fan_mount2();
    translate([410,0,42]) rotate([180,0,0]) fan_mount3();
}