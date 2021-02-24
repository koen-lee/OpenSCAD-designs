$fn=128;
module base(offset=0) {
    translate([-(135-68)/2,0,0]) cylinder(r=(68+offset)/2, h=30, center=true);
    translate([0,0,0]) cube([135-68,68+offset,30], center=true);
    translate([(135-68)/2,0,0]) cylinder(r=(68+offset)/2, h=30, center=true);
    
}
difference(){
    union(){
        difference(){
             
            base(3);
            translate([0,0,2])
                base(1);
        }
        translate([-13,0,0])
            cube([7,7,26],center=true);
       translate([60,-2,-7.1])
            cube([10,13,15],center=true);
    
    }
    translate([27,0,0])
    rotate([90,0,0])
    {
        jeenode_usb();
        
    }
}

module jeenode_usb(){
    cube([80.4,21.2,3.6], center=true);
    translate([45,0,3])
        cube([15,12,9],center=true);
    translate([35,0,3])
        cube([10,12,7],center=true);
    
}