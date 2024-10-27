use <MCAD\involute_gears.scad>;
$fn=32;
z=[0,0,1];

module mygear( n, bore )
{
        union(){
            gear(number_of_teeth = n, circular_pitch = 200, bore_diameter = bore,     hub_thickness=0, rim_thickness=12, rim_width = 20);
        }
}

 module rack() {
     // matches a gear with circular pitch 200
    pi=3.14159265;
    pitch = (pi*5*2)/9;
    dx = 1.3*cos(28);
    dy = 1.3*sin(28);
    translate([3-5,50-pitch/4,13])
    {
       linear_extrude(14) 
       polygon([[-2.5,3.5*pitch-dy],
                [-2.5,-dy],
                [-dx,0.0*pitch - dy],
                [ dx,0.0*pitch + dy],
                [ dx,0.5*pitch - dy],
                [-dx,0.5*pitch + dy],
                [-dx,1.0*pitch - dy],
                [ dx,1.0*pitch + dy],
                [ dx,1.5*pitch - dy],
                [-dx,1.5*pitch + dy],
                [-dx,2.0*pitch - dy],
                [ dx,2.0*pitch + dy],
                [ dx,2.5*pitch - dy],
                [-dx,2.5*pitch + dy],
                [-dx,3.0*pitch - dy],
                [ dx,3.0*pitch + dy],
                [ dx,3.5*pitch - dy],
                [-dx,3.5*pitch + dy]
                ]);
                
    }

}

module door_profile(){
     polygon([[0, 0],
              [0,40],
              [6,40],
              [4, 0]]);      
    }
module door_mount(){
    linear_extrude(10, convexity=10)
    {
        difference(){
            offset(r=5)
            {            
                // pivot
                polygon([[0,40],
                          [6,40],
                          [6,40],
                          [8,50],
                          [0,50]]);
                door_profile();
            }
            door_profile();
            // door glass
            polygon( [[4, 2],
                      [4,38],
                      [100,38],
                      [100, 2]]);
            // pivot
            translate([8,50])
                circle(r=1.5);
        }
    }
}

module door_pusher() {
    
    difference() {
        union() {
            translate([-3,-9,5])
            {
                cube([2.5,70,30]);
                cube([8,8,30]);
            }
            hull(){
                translate([-3,-9,10])
                     cube([2.5,70,20]);
                translate([-5,-5,13])
                     cube([2.5,65,14]);
            }
        }
        translate([-4,49.9,13])
             cube([100,25,14]);
    }
    rack();
}

module gear_part(){
    
    difference() {
        union() {
            intersection(){
                rotate([0,0,360/18/2])
                mygear(18,3);    /*pitch radius 10*/
                translate([-100,0,-50])
                cube([100,100,100]);
            }
            cylinder(r=8, h=12);
            cube([15,3,12]);
        }
        translate([0,0,-1])
            cylinder(d=3, h=100);
        
        translate([-1.5,5,-1])
            cube([3,15,14]);
        
        translate([-1.5,-20,-1])
            cube([3,15,14]);
        
    }
}

module handle() {
    
    difference(){
        union() {
            cylinder(r=10, h=3.8);
            translate([-1.5,5,0])
                cube([2.8,5,9]);
            
            translate([-1.5,-9,0])
                cube([2.8,4,9]);
            difference() {
                intersection()
                {
                    cylinder(r=10, h=9);
                    translate([-1,-50,0])
                        cube([100,100,100]);
                }
                cylinder(r=9, h=10);
            }
            // handle
            translate([9,-1.5,0])
            rotate([0,0,10])
            hull(){
                cube([40,3,9]);
                translate([0,-2,5])
                cube([35,10,4]);
            }
        }
        
        translate([0,0,-1])
            cylinder(d=3, h=100);
        translate([0,0,3.8])
            cube([15.5,3.2,12]);
    }
}

module door_clip(){
        
    difference(){ 
            door_mount();
        translate([-3,-10,5])
            cube([5,100,30]);
        translate([-3,-10,5])
            cube([100,20,30]);
    }
}

if($preview) {

door_clip();
color("blue"){
    door_pusher();
}

color("green")
translate([8,50,14])
{
    gear_part();
}

color("red")
translate([8,50,10.2])
{
    handle();
}
} else // print layout
{
    //gear_part();
    //handle(); 
    //door_pusher();
    door_clip();
}