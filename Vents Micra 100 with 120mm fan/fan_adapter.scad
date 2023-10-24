heat_exchanger_x = 170;
heat_exchanger_y = 125;
z = [0,0,1];
size=120; //mm fan square

module fan() {
    color("darkgrey")
    if( $preview){
        difference() {
            hull(){
                for(rot=[0:90:360])
                    rotate(z*rot)
                        translate([size/2-2,size/2-2])
                            cylinder($fn=8, h=25, r=2);
                    
            }
            translate(-z)
            {
                cylinder(d=size-10, h=30);
                cylinder(d1=size-2, d2=size-10, h=4);
                translate(z*23)
                cylinder(d2=size-2, d1=size-10, h=4);
            
                for(rot=[0:90:360])
                    rotate(z*rot)
                    {
                        // Mounting hole
                        translate([105/2,105/2])             
                            cylinder($fn=8, h=30, d=5);
                        
                        translate([size/2,size/2,3.5])
                            cylinder($fn=4, h=20, r=30);
                    }
                }
            }
        
        for(rot=[0:72:360])
            rotate(z*rot)
                cube([3,size/2-2, 2]);
        cylinder(h=3, d=40);
        
        rotate(z*-360*$t) {
            intersection()
            {
                cylinder(d = size - 14, h=30);
                translate(5*z)
                union(){
                     for(rot=[0:360/7:360])
                        rotate(z*rot)    // Fan blades
                             linear_extrude(15,twist=40, slices=5, convexity=10)
                                difference()
                                    { translate([30,-10]) circle(d=65);
                                      translate([30,-13]) circle(d=67);
                                    }
                    
                }
            }
            translate(z*5)        
            cylinder(h=15, d=40);
            
            translate(z*20)        
            cylinder(h=5, d1=40, d2=35);
        }
    }
}

module position_fan() {
    translate(z*15)
    rotate([0,-25,0])
    translate([72,0,0])
    {
        children();
    }
}

position_fan() fan();

difference() {
    union() {
        hull()
        position_fan()       
            for(rot=[0:90:360])
                rotate(z*rot)
                    translate([size/2-2,size/2-2,-2.1])
                        cylinder($fn=8, h=3, r=3);
        hull(){
            position_fan()       
                for(rot=[0:90:360])
                    rotate(z*rot)
                        translate([size/2-2,size/2-2,-2.1])
                            cylinder($fn=8, h=0.1, r=3);
                   
            translate([heat_exchanger_x/2,0])
                cube([heat_exchanger_x, heat_exchanger_y,0.4], center=true);
        }
        
        translate([heat_exchanger_x/2,0])
            cube([heat_exchanger_x+8, heat_exchanger_y+8,0.4], center=true);
        //strengthening ribs
        translate([85,0,27]) cube([0.8,126,54],center=true);
        hull(){
            translate([heat_exchanger_x,30,0]) cube([2,0.9,0.4], center=true);
            translate([122,-30,70]) cube([5,0.9,1], center=true);
        }
    }
    hull() {
        position_fan() translate(-z*2)
            intersection() { 
                cylinder(h=0.1, d=130);
                cube(120, center=true);
            }
        translate([heat_exchanger_x/2,0])
            cube([heat_exchanger_x-2, heat_exchanger_y-2,1.1], center=true);
    }
    hull(){
        position_fan()       
            for(rot=[0:90:360])
                rotate(z*rot)
                    translate([size/2-2,size/2-2])
                        cylinder($fn=8, h=3, r=2);
    }
    position_fan()translate(-z)
        intersection() { 
            cylinder(h=3, d=130, center=true);
            cube(120, center=true);
        }

    position_fan()  
    for(rot=[0:90:360])
        rotate(z*rot)
        {
            // Mounting hole
            translate([105/2,105/2,-10])             
                cylinder(h=30, d=5,$fn=16);
        }
}
