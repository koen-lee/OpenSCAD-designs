thickness=1.5; 


module housing_tray( thickness, innerSize ) {
    translate([1,1,1]*thickness)
    difference()
    {
        union(){
            translate([1,0,1]*-thickness)
                cube(innerSize + [2,0,0.999]*thickness);
            translate([0,1,1]*-thickness)
                cube(innerSize + [0,2,0.999]*thickness);
            translate([0,0,-thickness])
                cylinder(r=thickness, h=innerSize.z+0.999*thickness, $fn=16);
            translate([0,innerSize.y,-thickness])
                cylinder(r=thickness, h=innerSize.z+0.999*thickness, $fn=16);
            translate([innerSize.x,0,-thickness])
                cylinder(r=thickness, h=innerSize.z+0.999*thickness, $fn=16);
            translate([innerSize.x,innerSize.y,-thickness])
                cylinder(r=thickness, h=innerSize.z+0.999*thickness, $fn=16);
        } 
        
        cube(innerSize);   
                  
             translate([innerSize.x/5,0.01,thickness/sqrt(3)/2+innerSize.z-thickness])
                   scale([2.2,1.1,1.1])
                   rotate([0,-90,90])
                   cylinder(r1=thickness/sqrt(3), r2=thickness/2, h=thickness*1.01, $fn=3);
             
             translate([innerSize.x*4/5,0.01,thickness/sqrt(3)/2+innerSize.z-thickness])
                   scale([2.2,1.1,1.1])  
                   rotate([0,-90,90])
                   cylinder(r1=thickness/sqrt(3), r2=thickness/2, h=thickness*1.01, $fn=3);
                   
            translate([innerSize.x/5,innerSize.y-0.01,thickness/sqrt(3)/2+innerSize.z-thickness])     
                   scale([2.2,1.1,1.1])
                   rotate([0,-90,-90])
                   cylinder(r1=thickness/sqrt(3), r2=thickness/2, h=thickness*1.01, $fn=3);
             
             translate([innerSize.x*4/5,innerSize.y-0.01,thickness/sqrt(3)/2+innerSize.z-thickness])
                   scale([2.2,1.1,1.1])  
                   rotate([0,-90,-90])
               cylinder(r1=thickness/sqrt(3), r2=thickness/2, h=thickness*1.01, $fn=3);
     
    }
}

    module housing_lid(thickness, innerSize) {
    union(){
            cube([innerSize.x, innerSize.y, thickness] );                
             translate([innerSize.x/5,0,thickness/sqrt(3)/2])   
                   scale([2,1,1])
                   rotate([0,-90,90])
                   cylinder(r1=thickness/sqrt(3), r2=thickness/2, h=thickness*1.01, $fn=3);
             
             translate([innerSize.x*4/5,0,thickness/sqrt(3)/2])    
                   scale([2,1,1])  
                   rotate([0,-90,90])
                   cylinder(r1=thickness/sqrt(3), r2=thickness/2, h=thickness*1.01, $fn=3);
                   
            translate([innerSize.x/5,innerSize.y,thickness/sqrt(3)/2])   
                   scale([2,1,1])
                   rotate([0,-90,-90])
                   cylinder(r1=thickness/sqrt(3), r2=thickness/2, h=thickness*1.01, $fn=3);
             
             translate([innerSize.x*4/5,innerSize.y,thickness/sqrt(3)/2])    
                   scale([2,1,1])  
                   rotate([0,-90,-90])
               cylinder(r1=thickness/sqrt(3), r2=thickness/2, h=thickness*1.01, $fn=3);
     
        }
    
}

module thermostat() {
// pcb
    color([0,0.1,0.5,0.5])
    cube([78,51.2,1.5]);
// cable guides
    color([0,0.5,0.5,0.5]) {
        translate([70, 24, -10])
            cube([20,5,10]);
        
        translate([-10, 24, -10])
            cube([20,5,10]);
        
        translate([60, 43, -10])
            cube([5,20,10]);
    }
// displays
    color([0.7,0.7,0.7,0.5]){
        translate([10, 36, 1.5])
            cube([16,15,8]);
        translate([26, 30, 1.5])
            cube([26,21,8]);        
        translate([51, 36, 1.5])
            cube([16,15,8]);
    }
// leds
    color([0.7,0,0,0.5]){
        translate([14, 32.5, 1.5])
            cylinder(r=2.5,h=8, $fn=16);
    } 
    color([0,0.7,0,0.5]){
        translate([63.5, 32.5, 1.5])
            cylinder(r=2.5,h=8, $fn=16);
    } 
// buttons
    color([0.1,0.1,0.1,0.5]){
        translate([14, 22, 1.6])
            cylinder(r=2.5,h=10, $fn=16);
        translate([24.9, 22, 1.5])
            cylinder(r=2.5,h=10, $fn=16);
        translate([52.8, 22, 1.5])
            cylinder(r=2.5,h=10, $fn=16);
        translate([63.5, 22, 1.5])
            cylinder(r=2.5,h=10, $fn=16);
    } 
    
    
// mounting holes
    color([0.7,0.7,0.7,0.5]){
        translate([3.8, 3.8, 1.5])
            cylinder(r=1.5,h=100, center=true, $fn=16);
        translate([3.8, 46.5, 1.5])
            cylinder(r=1.5,h=100, center=true, $fn=16);
        translate([74, 3.8, 1.5])
            cylinder(r=1.5,h=100, center=true, $fn=16);
        translate([74, 46.5, 1.5])
            cylinder(r=1.5,h=100, center=true, $fn=16);
    } 
    
}

if($preview)
{     
    translate([thickness+1, thickness+1, pcbheight])
   % thermostat();
}

size = [80,53,23];
pcbheight = 15;
standoff = 6.4;
/*difference(){
    union(){
        housing_tray(thickness, size);
        translate([standoff,standoff,0]) 
            cylinder( r=3, h=pcbheight);
        translate([size.x-standoff + 2*thickness,standoff,0]) 
            cylinder( r=3, h=pcbheight);
        translate([standoff,size.y-standoff+ 2*thickness,0]) 
            cylinder( r=3, h=pcbheight);
        translate([size.x-standoff+ 2*thickness,size.y-standoff+ 2*thickness,0]) 
            cylinder( r=3, h=pcbheight);
    }
    
    translate([thickness+1, thickness+1, pcbheight])
        thermostat();
}*/
    
translate([0,60,0])
difference(){
    housing_lid(thickness, size);
    translate([1,1, -5])
        thermostat();
}
  