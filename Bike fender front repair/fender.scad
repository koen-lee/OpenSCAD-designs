module fender(offset){
rotate([90,0,0])
rotate_extrude(angle=100, convexity=4, $fn=128)
    translate([20*25.4,30])
    rotate([0,0,-90])
        offset(r=offset)
          import("fender_cut.svg");
}

module fender_front(offset)
{
    size = 61+2*offset;
    translate([0,0,-500])
    intersection()
    {
        fender(offset);
        union()
        {
            cylinder(d=size, h=600, $fn=64);
            translate([0,-size/2,0])
                cube([40,size,600]);
        }
    }
}

difference(){
    translate([0,0,20])
    rotate([0,130,0])
    { 
        intersection()
        {
           translate([-3,0,0])        
               fender_front(2);
            difference(){
               hull()    
               {
                   fender_front(2);
                   translate([-4,0,0])
                    fender_front(1);
               }
               fender_front(0.5);
            }
        }
    }
    translate([0,0,-50])
        cube([100,100,100], center=true);
}