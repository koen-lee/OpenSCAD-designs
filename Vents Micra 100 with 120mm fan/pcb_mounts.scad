z=[0,0,1];
$fn=8;
module dcdc_mount() {
    size = [20,43];
    mountinghole = [2.5, 5.5];
    
    difference() {
        linear_extrude(2)
            offset(r=1.2)square(size);
        translate(z*0.5)
            linear_extrude(2)
                difference(){
                    offset(r=0.2)square(size); 
                        
                translate(mountinghole)
                    circle(d=4.5);
                translate(size-mountinghole)
                    circle(d=4.5);
                translate([mountinghole.x, size.y-mountinghole.y])
                    circle(d=2);
                translate([size.x-mountinghole.x, mountinghole.y])
                    circle(d=2);
                
            }
        translate(-z){
            translate(mountinghole)
                cylinder(d=2.5, h=4, $fn=8);
            translate(size-mountinghole)
                cylinder(d=2.5, h=4, $fn=8);
        }
        
        translate(z*1.5)
            linear_extrude(2)
                    offset(r=0.1)square(size); 
    }
    
}

module pwm_mount() {
    size= [30,32];
    
    mountingholes = [25.4, 27.5]/2;
    difference() {
        linear_extrude(2)
            offset(r=1.5)square(size, center=true);
        translate(z*0.5)
            linear_extrude(2)
                difference(){
                    offset(r=0.5)square(size, center=true); 
                        
                translate(mountingholes)
                    circle(d=4);
                translate(-mountingholes)
                    circle(d=4);
                translate([mountingholes.x, -mountingholes.y])
                    circle(d=4);
                translate([-mountingholes.x, mountingholes.y])
                    circle(d=4);
                
            }
        translate(-z){
            translate(mountingholes)
                cylinder(d=2, h=4);
            translate(-mountingholes)
                cylinder(d=2, h=4);
            
            translate([mountingholes.x, -mountingholes.y])
                cylinder(d=2, h=4);
            translate([-mountingholes.x, mountingholes.y])
                cylinder(d=2, h=4);
        }
        
        translate(z*1.5)
            linear_extrude(2)
                    offset(r=0.1)square(size, center=true); 
    }
}

dcdc_mount();
translate([37,21])
    pwm_mount();
translate([23,1.8]){
    difference(){
        cylinder(d=5.5, h=2);
        cylinder(d=2.5, h=8, center=true);
    }
}
translate([23,40.3]){
    difference(){
        cylinder(d=5.5, h=2);
        cylinder(d=2.5, h=8, center=true);
    }
}