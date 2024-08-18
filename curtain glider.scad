$fn=64;
z=[0,0,1];

r=16;
d=1.3;
w=22;
difference() {
    union(){
        cube([40,w,1]);
        translate(z*(r+d)) rotate([-90,0]) cylinder(r=r+d, h=w);
        translate(z*(r+d))
        rotate([0,-45,0])
            translate([-2,0,(r+d-0.2)])
            {   cube(2);
                translate([0,w-2]) cube(2);
            }
    }
    translate([38,2,-1]) cube([4,w-4,4]);
    translate([0,-1,r+d]) rotate([-90,0])  cylinder(r=r, h=w+2);
    translate([0,-2,r+d]) rotate([-90,0])  cylinder(r1=r+1, r2=r, h=w/3);
    translate([0,(2*w/3)+2,r+d]) rotate([-90,0])  cylinder(r1=r, r2=r+1, h=w/3);
    translate([0,-1,1])
        cube([50,w+2,2*r]);
    
    translate([0,-1,r+d])
        rotate([0,-45,0])
            cube([r+d+1,w+2,r+d+1]);
    
    translate([5, 0,0]) scale([1,1.5,1]) cylinder(center=true, d=5, h=5);
    translate([5, w,0]) scale([1,1.5,1]) cylinder(center=true, d=5, h=5);
    
    translate([22, 0,0]) scale([5,3,1]) cylinder(center=true, d=5, h=5);
    translate([22, w,0]) scale([5,3,1]) cylinder(center=true, d=5, h=5);
}