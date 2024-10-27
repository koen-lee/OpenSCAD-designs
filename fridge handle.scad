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
       polygon([[-2.5,3*pitch-dy],
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
                [-dx,3.0*pitch - dy]
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


difference(){
    union(){
        door_mount();
        translate([0,0,30])
            door_mount();
    }
    translate([-3,-10,5])
        cube([100,100,30]);
}

color("blue"){
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
        translate([-4,40,13])
             cube([100,20,14]);
    }
}



color("green")
translate([8,50,14])
    mygear(18,3);    /*pitch radius 10*/
    
color("red") {
    rack();
}