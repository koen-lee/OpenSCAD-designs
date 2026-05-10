//tray_inner_x = 207; //mm
//tray_inner_y = 482; //mm
//tray_inner_z = 40;  //mm
tube_diameter = 25;
// tube_length = 94
block_x = 480/4;//fits 5 tubes
block_y = 205/2;//fits 1 tube
side = 10;
height = 30;
tube_width = block_x / 5;
intersection() {
    cube([block_x,block_y,height]);    
    difference() {
        union() {
            difference() {
                //Frame
                union(){
                    cube([block_x,side,height]);
                    cube([3,block_y,15]);
                    cube([15,block_y,1]);
                    translate([block_x-3,0])
                    cube([3,block_y,5]);
                    cube([block_x,side,height]);
                    translate([0,block_y-side])
                    cube([block_x,side,height]);
                }
                
                translate([15, 2,-1])
                    cube([block_x-15-15,side,height]);
                translate([15, block_y-2-side,-1])
                    cube([block_x-15-15,side,height]);
            }


            // Tubes
            for(tube=[0:4])
            { 
                hull() {
                    translate([tube_width/2 + tube_width * tube,0, 40-tube_diameter/2])
                    rotate([-90,0])
                        cylinder(h=side, d=tube_width);
                    translate([tube_width * tube,1])
                    cube([tube_diameter-1,1,1]);
                }


                translate([tube_width * tube,block_y-side,10-1])
                hull() {
                    hull(){
                        translate([22,0])
                        rotate([-90,0])
                            cylinder(h=side, d=3, $fn=16);
                        translate([-3,0,25])
                            cube([30, side, 1]);
                    }
                    translate([0,side-2,-9])
                    cube([tube_diameter-1,2,1]);
                }
            }
        }

        // Negative Tubes
        for(tube=[0:4])
        {
            translate([tube_width/2 + tube_width * tube,1, 40-tube_diameter/2])
            rotate([-90,0])
                cylinder(h=side, d=tube_diameter);
            
            translate([tube_width * tube,block_y-side-1,10])
                hull(){
                    translate([22,0])
                    rotate([-90,0])
                        cylinder(h=side, d=3, $fn=16);
                    translate([-3,0,25])
                        cube([30, side, 1]);
                }
        }
        
        // Connecting rods
        dx=12;
        dz=4;
        translate([dx,0,dz])
            connector();
        translate([dx,block_y,dz])
            connector();
        
        translate([block_x-dx,0,dz])
            connector();
        translate([block_x-dx,block_y,dz])
            connector();
        
        translate([0,side/2,dz])
            connector(90);
        translate([0,block_y-side/2,dz])
            connector(90);
        translate([block_x,side/2,dz])
            connector(90);
        translate([block_x,block_y-side/2,dz])
            connector(90);
    }

}

module connector(z=0) {
    rotate([90,0,z]){
        cylinder(d=5.1, h=15, center=true, $fn=32);    
        cylinder(d=7.1, h=1, center=true, $fn=32);
    }
}