$fn=32;
offset = 7;
module T(r,e)
{
    offcenter=1.5;
    union()
    {
        translate([0,0,-5-e])
            cylinder(h=5+2*e, r1=r+1.3, r2=r+1.6);
        cylinder(h=offset/2, r1=r+1.6, r2=r/2);
        translate([-offset-offcenter,0,0])
            bend(r, 0);
        translate([-offset+e-offcenter,0,offset])
            rotate([0,270,0])
            cylinder(h=35+2*e-2*offset-offcenter, r=r);
        translate([-35+offset,0,2*offset])
            bend(r, 180);
        translate([-35,0,2*offset-e])
            cylinder(h=5+2*e, r=r);
        
        
        translate([offset+offcenter,0,0])
            bend(r, -90);
        translate([offset+offcenter-e,0,offset])
            rotate([0,90,0])
            cylinder(h=35+2*e-2*offset-offcenter, r=r);
        translate([35-offset,0,2*offset])
            bend(r, 90);
        translate([35,0,2*offset-e])
            cylinder(h=5+2*e, r=r);
        
    }
}

module bend(r, rotate){
    rotate([0,0,0])
    rotate([90,rotate,0])
    rotate_extrude(angle=90, convexity=4)
        {
            translate([offset,0])
                circle(r);
        }    
}

module pipe(){
    difference()
    {
        union()
        {
            T(3.5, 0.001);
            translate([-32.5,-1,6])
                cube([65,2,13]);
        }
        T(2.5, 0.01);
    }
}

module ring(){
    difference()
    {
        cylinder(r=4.5, h=2);
        cylinder(r=3.4, h=20, center=true);
        translate([0,-40.5,-1])
            cube([10,1,10]);
    }
}
 
rotate([0,90,0])
difference()
{
    pipe();
    translate([50,0,0])
        cube([100,100,100],center=true);
    translate([-5,0,12])
    rotate([90,0,0])
        cylinder(h=10, r=2, center=true);
}