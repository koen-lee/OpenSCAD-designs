
build = "fan_mount_plate";//  [fan_mount_plate, fan_mount, sidewall]
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
h2 = 41;
h3 = 25;
h1 = 54 + h2 + h3;

module ramp_2d()
{
    offset = [-70,-0];
    hull() {
    translate( offset) circle(d=2, $fn=16); 
    rotate(-3)
       translate( offset) circle(d=2, $fn=16);         
    }
    
    hull() {
    rotate(-3)
    translate(offset) circle(d=2, $fn=16); 
    rotate(-6)
       translate(offset) circle(d=3, $fn=16);         
    }
    hull() {
    rotate(-6)
    translate(offset) circle(d=3, $fn=16); 
    rotate(-10)
       translate(offset) circle(d=4, $fn=16);         
    }
}

module ramp() 
{
    intersection() {
        tw=10;
        union(){            
            translate([0,0,25]) 
            linear_extrude(25, convexity=3, twist=-tw, slices=20)
                ramp_2d();  
            rotate([0,0,tw]){
                linear_extrude(25, convexity=3, twist=tw, slices=20)
                   ramp_2d();
                
                translate([0,0,50]) 
                linear_extrude(30, convexity=3, slices=2)
                   ramp_2d();                            
            }            
            translate([0,0,-h2+3]) 
            linear_extrude(h2-3, convexity=3, twist=-tw, slices=2)
               ramp_2d();     
        }
    }
}
module sidewall() 
{
    h=h1;
    translate([0,0,1.01])
    difference() {
        union() {
            translate([0,0,-h2])
            rotate([0,0,-180])                                    
                linear_extrude(h, convexity=10)
                    spiral(); 
            //ramp();
            
            intersection(){
                translate([0,0,-h2])
                rotate([0,0,-180])
                linear_extrude(h, convexity=10)
                    hull() 
                        intersection(){
                            spiral();
                            square([300,200], center=true);
                        }
                    
                translate([0,-h,30])
                {
                    rotate([0,30,-30])
                    cube(200);     
                    rotate([0,60,-30])
                    cube(200);
                }
            }
            
        hull()
        {
            translate([-69,-1,20]) sphere(d=1);            
            translate([-68,15,00]) sphere(d=1);
            translate([-80,12,00]) sphere(d=1);
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

module fan_mount_plate(){
    h=h2;
    rotate([0,0,-180])
    translate([0,0,-h])
    difference(){
        union(){
            linear_extrude(1, convexity=10)
                hull() spiral();   
            linear_extrude(3, convexity=10)
            {    intersection(){
                    offset(1) spiral();
                    hull() spiral();   
                }
                
                 offset(-5)
                 offset(5)
                 {
                    circle(r=65);                 
                    for(rot=[15:60:360]){
                        rotate([0,0,rot]){
                            translate([68,0])
                                circle(d=10);
                        }
                    }
                }
            }
                
        }
        translate([0,0,1])
        linear_extrude(20, convexity=10)
        
            offset(r=0.15)
            import("spiral.svg");
                      
        translate([0,0,-0.01])      
         cylinder(h=h, r1=64.2, r2=40);
        
        for(rot=[15:60:360]){
            rotate([0,0,rot]){
                translate([68,0])
                    cylinder(d1=3, d2=3,h=8, center=true);
            }
        }
    } 
}

module fan_mount(){
    
    h=h2;
      translate([0,0,-h])
     difference(){
         union() {
            cylinder(h=h, r1=64, r2=40);
            translate([0,0,-1])
             linear_extrude(1)
             offset(-5)
             offset(5)
             {
                circle(r=65);                 
                for(rot=[15:60:360]){
                    rotate([0,0,rot]){
                        translate([68,0])
                            circle(d=10);
                    }
                }
            }
                 
         } 
        translate([0,0,-2])
            cylinder(h=h, r1=64, r2=40-0.8);
        
        // fan mounting holes
         translate([-3,3])
        for(rot=[0:90:360]){
            rotate([0,0,rot]){
                translate([20.2,20.2,h])
                    cylinder(d1=4.5, d2=4.5,h=5, center=true);
            }
        }
        // Cable hole
        translate([-3,3,h]) rotate([0,0,45])
            cube(49, center=true);
        // plate mounting holes
        for(rot=[15:60:360]){
            rotate([0,0,rot]){
                translate([68,0])
                    cylinder(d1=3, d2=3, h=5, center=true);
            }
        }
    }
}

module fan_intake(){
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
                cylinder(h=h+3, r1=50-1, r2=64-1);     
        
    } 
}

if( $preview)
{    
    translate([-3,3,1])
    fan();        
    fan_mount();
    color("lightgreen")
    fan_mount_plate();
    color("orange")
  {   fan_intake();
      sidewall();
  }
} else {     
    if( build == "fan_mount_plate")
        fan_mount_plate();
    if( build == "fan_mount")
    translate([200,0]) fan_mount();
    if( build == "sidewall")
    translate([410,0,42]) rotate([180,0,0])        
    rotate([0,0,-15]){
        fan_intake();
        sidewall();
    }
}