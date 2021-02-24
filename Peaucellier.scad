// https://math.stackexchange.com/questions/256100/how-can-i-find-the-points-at-which-two-circles-intersect
function intersections_circle(p1, r1, p2, r2) = 
    let (d = sqrt((p1.x - p2.x)^2+(p1.y-p2.y)^2))
    let (l = (r1^2-r2^2+d^2)/(2*d))
    let (h = sqrt(r1^2-l^2))
    [
        [(l/d)*(p2.x-p1.x)+(h/d)*(p2.y-p1.y)+p1.x,(l/d)*(p2.y-p1.y)-(h/d)*(p2.x-p1.x)+p1.y],
        [(l/d)*(p2.x-p1.x)-(h/d)*(p2.y-p1.y)+p1.x,(l/d)*(p2.y-p1.y)+(h/d)*(p2.x-p1.x)+p1.y ]
    ];


module linkage(a, b)
{    
    L = sqrt((a.x-b.x)^2+(a.y-b.y)^2);
    translate(a)
        rotate([0,0,atan2((b.y-a.y),(b.x-a.x))])
        {
           difference(){
               union(){
                    cylinder(h=1, r=2, center=true);
                    translate([L/2,0,0])
                        cube([L,3,1], center=true);
                    translate([L,0,0])
                        cylinder(h=1, r=2, center=true);
               }
               cylinder(h=2, r=1, center=true);
               translate([L,0,0])
                  cylinder(h=2, r=1, center=true);
               }
        }
}

module mount() {
    difference(){
        translate([-10,0,1])
            cube([30,20,15], center=true);
        
        translate([5,0,1.5])
            cube([25,25,9], center=true);
        
        translate([-5,0,0.5])
            cube([25,25,3], center=true);
        cylinder(h=135, r=2, center=true);
        translate([-10,0,0])
        cylinder(h=135, r=1, center=true);
    }
}

module crank() {
    cylinder(h=8,r=1.9);
    scale([1,1,2])
    linkage([0,0],[10,0]);    
}

// if not previewing, show print layout
inPreview = $preview;
angle = 0;
$fn=32;
if( inPreview )
{
    angle = 115*sin(360*$t);
} 
C = 10*[cos(angle), sin(angle)];

d = [-10,0];
dr = 30; 

cell_length = 20;
intersections = intersections_circle(d, dr, C, cell_length);
D = intersections[0];
E = intersections[1];
F = intersections_circle(D, cell_length, E, cell_length)[0];


if( inPreview ) {
    linkage(d, D);
    translate([0,0,1])
        linkage(d, E);
    color("blue") {    
    translate([0,0,2])
        linkage(E, F);
    translate([0,0,1])
        linkage(D, F);
    translate([0,0,2])
        linkage(C, D);
    translate([0,0,3])
        linkage(C, E);
    }
    color("darkgreen")
        mount();
    color("red")
        rotate(angle)
        {
        translate([0,0,4.6])
            crank();
            
        translate([0,0,-1.6])
            rotate([180,0,0])
                crank();
        }
} else {
    translate([0,0,0.5])
        linkage(d, D);
    
    translate([0,10,0.5])
        linkage(d, E);
    translate([10,20,0.5])
        linkage(E, F);
    translate([-10,15,0.5])
        linkage(D, F);
    translate([10,0,0.5])
        linkage(C, D);
    translate([0,0,0.5])
        linkage(C, E);
    translate([40,0,25])
        rotate([0,-90,0])
            mount();
    translate([40,30,1])
    crank();
    translate([40,40,1])
    crank();
}