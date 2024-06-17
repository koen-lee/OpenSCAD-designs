module torus() {
    rotate_extrude() {
        translate([4,0])
            circle(r=1, $fn=16);
    }
}
module roundedbox(w,h,d){
    // torus has r=5 h=2
    tr = 5;
    trh = 1;
    hull(){        
        translate([  tr,  tr,  trh])torus();
        translate([w-tr,  tr,  trh])torus();
        translate([w-tr,h-tr,  trh])torus();
        translate([  tr,h-tr,  trh])torus();
        translate([  tr,  tr,d-trh])torus();
        translate([w-tr,  tr,d-trh])torus();
        translate([w-tr,h-tr,d-trh])torus();
        translate([  tr,h-tr,d-trh])torus();
    }
}
module phone(){
    roundedbox(    w=77,    d=/*13.8*/25,    h=160);
}


difference() {
    union() {        
        translate([0,0,40])
            roundedbox(97,15,20);
        
        translate([97/2, 13.5, 40])
            cylinder(d=6, h=20, $fn=16);
    }
    translate([10,12,30])
    {
        rotate([90,0,0])
        {
            phone();                                               
        }
    }         
    translate([97/2, 13.5, 15])
            cylinder(d=3.7, h=70, $fn=16);
    hull()
    {
        translate([10,-5,40])
            cube([77, 15, 20]);
        translate([5,-5,60])
            cube([87, 5, 20]);
    }
}

//*/
