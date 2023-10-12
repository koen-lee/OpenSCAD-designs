heat_exchanger_x = 130;
heat_exchanger_y = 150;
z = [0,0,1];

module fan(size=120) {
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
                        translate([size/2-4,size/2-4])             
                            cylinder($fn=8, h=30, r=2);
                        
                        translate([size/2,size/2,3.5])
                            cylinder($fn=4, h=20, r=30);
                    }
                }
            }
        
        for(rot=[0:72:360])
            rotate(z*rot)
                cube([3,size/2-2, 2]);
        cylinder(h=3, d=40);
        
        intersection()
        {
            cylinder(d = size - 14, h=30);
            union(){
                 for(rot=[0:72:360])
                    rotate(z*rot)                        
                        translate([0,0,15])
                        rotate([70,0,0])
                            translate([0,0,-20])
                            cube([size, 2, 40]);
            }
        }
        translate(z*5)        
        cylinder(h=15, d=40);
        
        translate(z*20)        
        cylinder(h=5, d1=40, d2=35);
        
    }
}

fan();