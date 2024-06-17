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

module chargecable()    //offset 29%36=32.5
{
    translate([32.5,0.01,7.2])
    {
        rotate([90,0,0])
        {
        color("white") cylinder(d=6.5,h=20, $fn=32);
        color("white") cylinder(d=4,h=24, $fn=32);
        color("gray") hull()
            {
                translate([-2,0]) cylinder(h=14, d=6.5, $fn=32);
                translate([ 2,0]) cylinder(h=14, d=6.5, $fn=32);
            }
            
        }
    }
    
}

difference() {
    union() {
        hull() {
            rotate([10,0])roundedbox(97,50,5);
            translate([0,0,10])
             roundedbox(97,15,15);
        }
        translate([0,0,10])
            roundedbox(97,15,50);
        
        translate([97/2, 13.5, 10])
            cylinder(d=6, h=50, $fn=16);
    }
    translate([10,12,30])
    {
        rotate([90,0,0])
        {
            phone();
            chargecable();
            translate([32.5,0.01,7.2]){
                translate([0,-30,15])
                    cube([4,60,30], center=true);
                
                translate([0,-35,0])
                    cube([4,28,95], center=true);
            }
                            
        }
        
        translate([32.5,0.01,-26])
        rotate([100,0,0])
            cylinder(d=4, h=95, center=true, $fn=8);
        
           
    }
        

    translate([97/2, 13.5, 15])
            cylinder(d=3.7, h=70, $fn=16);
}
//*/
