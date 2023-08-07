width = 107.5;
height = 65;
depth = 25;

bolt_x = 69;
bolt_z = 56.7;

module scope()
{
    hull() {
    // Scope PCB itself
    cube([width, depth, height]);
    // Make sure the front is clear
    translate([2,0,2])
        cube([width-4, depth+2, height-4]);
    }
    // Probe hole
    translate([width,10,8.5])
        rotate([0,90,0])
            cylinder(h=20,center=true,d=10);
    // Power supply hole
    translate([0,8.6,6.5]) 
        cube([20,13,8],center=true);
    // Test waveform probe
    translate([90,11,65]) 
        cylinder(h=20,d=5.5,center=true);
    // Mounting holes
    for(x=[0,bolt_x])
        for(z = [0,bolt_z])
            translate([(width - bolt_x)/2+x,0,(height - bolt_z)/2+z])
                rotate([90,0,0])
                cylinder(h=20, d=3, $fn=32, center=true);
    // Piggyback 9V battery
    translate([width/2, 1, 16]) {
        cube([46,16.5,26], center=true);
    }
}

module material_saver_half() {
    rotate([90,0,0])
    linear_extrude(20, center=true, convexity=10)
    {
        offset(r=1.5, $fn=16)
        offset(r=-1.5) /**/ {
            polygon([[1,1],
                     [10,1],
                     [20,10],
                     [1,28]]);
            
            polygon([[2,29],
                     [28,29],
                     [28,11],
                     [21,11]]);
            
            polygon([[1,64],
                     [10,64],
                     [17,57],
                     [1,31]]);
            
            polygon([[2,30.5],
                     [28,30.5],
                     [28,56],
                     [18,56]]);
            
            polygon([[31,30.5],
                     [50,30.5],
                     [31,61]]); 
            polygon([[50,32.5],
                    // [31,58.5],
                     [31,64],
                     [50,64]]);
        }
    }
}

module material_saver() {
    material_saver_half();
    translate([width,0,0])
    mirror([1,0,0])
        material_saver_half();
}


module housing() {
    difference(){
        hull() {
            for(x=[0,width])
                for(z = [0,height])
                    for(y=[0,depth])
                        translate([x,y,z])
                            sphere(1, $fn=16);                               
        }       
        scope();   
        material_saver();
        translate([width/2,0,0])
            cube([4,900,900],center=true);
    }
}

housing();