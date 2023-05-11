z = [0,0,1];
$fn=60;

idler_offset = 7;
lids = false;
module rotor()
{
    difference(){
        union(){
            difference(){
                cylinder( d=100, h=20);
                 
                translate(5*z)
                    cylinder( d=90, h=20);
                translate(2*z)
                    cylinder( d=9, h=20, $fn=6);
                translate(-2*z)
                    cylinder( d=6, h=20, $fn=60);
                
                
                translate([45,0,5])
                    cylinder( d=5, h=20);
                translate([-45,0,5])
                    cylinder( d=5, h=20);
            }
           
            translate([45,0,10])
                cylinder( d=5, h=5);
            translate([-45,0,10])
                cylinder( d=5, h=5);
            
        }       
    }
}
 
module valve(l, r)
{
    difference(){          
        union(){
            translate([0,0,0])
                cylinder( d=5, h=5);
            translate([0,0,10])
                cylinder( d=5, h=5);
            translate([l,0,5])
                cylinder( d=5, h=5);
            translate([0,-1.5,0])
            rotate(z*r)
                cube([l,1,15]);
        }
        
        translate([0,0,-1])
            cylinder( d=2, h=50);
        translate([l,0,-1])
            cylinder( d=2, h=50); 
        
        translate([0,0,5])
            cylinder( d=5, h=5);
        translate([l,0,-0.01])
            cylinder( d=5, h=5);
        translate([l,0,10])
            cylinder( d=5, h=5.01);
    }
}

module valve_pair(xy2,xy1)
{
    diff = xy2-xy1;
    distance = norm(diff);
    angle_between_points = atan2(diff[1],diff[0]);
    l=30;
    
    angle_for_distance = acos(distance/(2*l));
    xy3 = [l*cos(angle_for_distance),l*sin(angle_for_distance)];
    translate(xy1) {
        rotate(z*angle_between_points) {
            rotate(z*angle_for_distance)
                valve(l,0);
            translate(xy3)
            rotate(-z*angle_for_distance)
                valve(l,0);
        }
    }
    surface = (distance * l * sin(angle_for_distance))/2;
    echo( surface = surface);
}

module box1() {
     difference() {
        union(){
                translate(20*z) {
                    if(lids)
                       cylinder(d=110, h=5);
                }
                 translate([0,40,20])
                    cylinder( d1=10, d2=9.5, h=10);
                translate([0,-40,20])
                    cylinder( d1=10, d2=9.5, h=10);
            }
        box2();
       translate([0,40,19])
            cylinder( d=7, h=12);
        translate([0,-40,19])
            cylinder( d=7, h=12);
    
        
    }
     translate([idler_offset,0,15])
                    cylinder( d=4.5, h=11);
}

module box2() {
     difference() {
        cylinder(d=105, h=25);
        translate(2*z)
            cylinder(d=101, h=50);
        cylinder(d=8, h=50, center=true);
    } 
}


phase = 360*$t;


x1_idler = idler_offset;
y1_idler = 0;

x1_rotor = 45*cos(phase);
y1_rotor = 45*sin(phase);

x2_idler = idler_offset;
y2_idler = 0;

x2_rotor = 45*cos(phase+180);
y2_rotor = 45*sin(phase+180);

box1();
translate(-2*z)
box2();
color("blue")
    rotate(phase*z)
        rotor();



color("red")
    translate(5*z) {
        valve_pair([x1_idler,y1_idler],[x1_rotor,y1_rotor]);
        valve_pair([x2_idler,y2_idler],[x2_rotor,y2_rotor]);
    }
 