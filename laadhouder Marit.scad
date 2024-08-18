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
    roundedbox(    w=78.5,    d=/*13.8*/25,    h=160);
}

module chargecable()    
{
    translate([78.5/2,0.01+1.,5.2])
    {
        rotate([90,0,0])
        {
        color("white") cylinder(d=7,h=25, $fn=32);
        color("white") cylinder(d=3.5,h=27, $fn=32);
        color("gray") hull()
            {
                // width 12.1 d7.7 = 4.4 hoh
                translate([-2.2,0]) cylinder(h=20, d=7.7, $fn=32);
                translate([ 2.2,0]) cylinder(h=20, d=7.7, $fn=32);
            }
        
        color("lightgray") hull()
            {
                // width 8.4 d2.4 = 6 hoh
                translate([-3,0,-6.7]) cylinder(h=20, d=2.4, $fn=32);
                translate([ 3,0,-6.7]) cylinder(h=20, d=2.4, $fn=32);
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
            translate([78.5/2,0.01,7.2]){
                translate([0,-30,15])
                    cube([3.5,60,30], center=true);
                
                translate([0,-35,0])
                    cube([3.5,28,95], center=true);
            }
                            
        }
        
        translate([78.5/2,0.01,-26])
        rotate([100,0,0])
            cylinder(d=3.5, h=95, center=true, $fn=8);
        
           
    }
        

    translate([97/2, 13.5, 15])
            cylinder(d=3.7, h=70, $fn=16);
    
    hull()
    {
        translate([10,-5,40])
            cube([78.5, 15, 20]);
        translate([5,-5,60])
            cube([87, 5, 20]);
    }
    
    hull()
    {
        translate([55,-3,31])
            cube([10, 15, 2]);
        translate([55+7,-5,30])
            rotate([90,0,0])
            cylinder(r=7, h=1);
    }
}
if($preview){
    translate([10,12,30])
    {
        rotate([90,0,0])
        { 
            chargecable();
        }
    }
}
//*/
