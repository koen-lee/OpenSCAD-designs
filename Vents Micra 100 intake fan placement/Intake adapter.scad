
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

module spiral(){
    import("spiral.svg");
}
h2 = 40;
h3 = 25;
h1 = 55 + h2 + h3;

module ramp_2d()
{
    offset = [-63.8,-5];
    hull() {
    translate( offset) circle(d=2, $fn=16); 
    rotate(-3)
       translate( offset) circle(d=2, $fn=16);         
    }
    
    hull() {
    rotate(-3)
    translate(offset) circle(d=2, $fn=16); 
    rotate(-6)
       translate(offset) circle(d=2, $fn=16);         
    }
    hull() {
    rotate(-6)
    translate(offset) circle(d=2, $fn=16); 
    rotate(-10)
       translate(offset) circle(d=2, $fn=16);         
    }
}

module ramp() 
{
    intersection() {
       /* translate([0,0,-h2])
            rotate([0,0,-180])
        linear_extrude(h1, convexity=10)
            hull() spiral();*/
        tw=10;
        union(){            
            translate([0,0,25]) 
            linear_extrude(25, convexity=3, twist=-tw, slices=20)
                ramp_2d();  
            rotate([0,0,tw]){
            linear_extrude(25, convexity=3, twist=tw, slices=20)
               ramp_2d();
            
            translate([0,0,50]) 
            linear_extrude(30-2, convexity=3, slices=2)
               ramp_2d();               
            
            translate([0,0,-h2+2]) 
            linear_extrude(h2-2, convexity=3, slices=2)
               ramp_2d();               
            }
        }
    }
}
module fan_mount1() 
{
    h=h1;
    difference() {
        union() {
            translate([0,0,-h2])
            rotate([0,0,-180])                                    
                linear_extrude(h, convexity=10)
                    spiral(); 
            ramp();
            
            intersection(){
                translate([0,0,-h2])
                rotate([0,0,-180])
                linear_extrude(h, convexity=10)
                    hull() spiral();
                    
                translate([0,-h,30])
                {
                    rotate([0,30,-30])
                    cube(200);     
                    rotate([0,60,-30])
                    cube(200);
                }
            }
        }
        translate([1.0,-h,30]) {
            rotate([0,30,-30])
            cube(200);     
            rotate([0,60,-30])
            cube(200);
        }
    }
}

module fan_mount2(){
    h=h2;
    rotate([0,0,-180])
    translate([0,0,-h])
    difference(){
        union(){
            linear_extrude(1, convexity=10)
                hull() spiral();   
            linear_extrude(3, convexity=10)
                intersection(){
                    offset(1) spiral();
                    hull() spiral();   
                }
                
            cylinder(h=h, r1=64, r2=40);
        }
        translate([0,0,1])
        linear_extrude(20, convexity=10)
        
            offset(r=0.15)
            import("spiral.svg");
                            
        translate([0,0,-2])
            cylinder(h=h, r1=64-0.8, r2=40-0.8);
        
        // fan mounting holes
        for(rot=[0:90:360]){
            rotate([0,0,rot]){
                translate([20.2,20.2,h])
                    cylinder(d1=4.5, d2=4.5,h=5, center=true);
            }
        }
        // Cable hole
        translate([0,0,h]) rotate([0,0,45])
            cube(50, center=true);
    } 
}

module fan_mount3(){
    h=h3;
    rotate([0,0,-180])
    translate([0,0,55+h])
    difference(){
        union(){            
            translate([0,0,1])
                linear_extrude(1, convexity=10)
                    hull() spiral(); 
            
            translate([0,0,-1])
            linear_extrude(2, convexity=10)
                intersection(){
                    offset(1) spiral();
                    hull() spiral();   
                }
            
            translate([0,0,-h])
            cylinder(h=h+2, r1=50, r2=64);
        }
        translate([0,0,-5])
        linear_extrude(6, convexity=10)
            offset(r=0.1)
                import("spiral.svg");
          
            translate([0,0,-h-0.5])
                cylinder(h=h+3, r1=50-1.5, r2=64-1.5);     
        
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

if( $preview)
{    
    
    fan();        
    color("lightblue")
  //  space();
    fan_mount1();
    fan_mount2();
    color("orange")
    fan_mount3();
} else {
    rotate([0,0,-15]){
    fan_mount1();
   // translate([200,0]) fan_mount2();
   // translate([410,0,42]) rotate([180,0,0]) fan_mount3();
    }
}