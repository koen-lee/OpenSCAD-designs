width  = 157;
height = 165.5;
r1     =   2;
r2     =  30;
thick  = 1.2;
h      =  9;

$fn=64;
module shape() {
    hull(){
        for(m=[0:1])
        mirror([m,0,0])
        {
            translate([(width/2)-r1,165-r1])
                circle(r=r1);
            translate([(width/2)-r2,r2])
                circle(r=r2);
        }
    }
}


difference(){
    linear_extrude(h, convexity=4)
    {
        offset(3*thick)
        offset(-5*thick)
        shape();
    }
    translate([0,0,-thick])
    linear_extrude(h+2*thick, convexity=4)
    {
        offset(thick)
        offset(-5*thick)
        shape();
    }
    translate([0,90,thick+2])
        cube([1000,5,4],center=true);
}

difference() {
    
    linear_extrude(thick, convexity=4)
    {
        offset(3*thick)
        offset(-5*thick)
        shape();
    }
    translate([0,4,-0.1])
    scale([16,16,10]) {            
        d=0.9;
        for(x=[-8:8])
        for(y=[0:25])
        {
            translate([x*1.5,y*sqrt(3)/2])
                cylinder(h=1, d=d, $fn=6);
            
            translate([x*1.5 + 0.75,(y + 0.5)* sqrt(3)/2])
                cylinder(h=1, d=d, $fn=6);
        }
    }
}

// center spring container
translate([0,90])
{
    difference() {
        hull() {
            translate([0,0,4])
            cube([3,20,8], center=true);
            translate([0,0,thick/2])
            cube([40,20,thick], center=true);
        }
        translate([0,0,3+thick])
        rotate([0,90,0])
            cylinder(d=4.1, h=20, center=true);
        translate([22,0,4+thick])
            cube([40,17,8], center=true);
        translate([-22,0,4+thick])
            cube([40,17,8], center=true);

    }
}
// stiffness center spar 
translate([-75,99,0])
    cube([150,1,8]);

if( $preview ) {
    translate([0,90,3+thick])
    rotate([0,90,0]) {
        color("red")
            cylinder(d=4, h=20, center=true);
        color("blue") {
            cylinder(d=2.5, h=36, center=true);
            translate([0,0,18])
                cylinder(d1=2.5, d2=0, h=2);
            
            translate([0,0,-20])
                cylinder(d1=5, d2=2.5, h=2);
        
        }
    }
    dx=2+4+4*sin(360*$t);
    color("green"){
        translate([dx,90,thick+0.1])
            lock_bolt();
        mirror([1,0,0])
        translate([dx,90,thick+0.1])
            mirror([0,1,0])
            lock_bolt();
    }  
} else {
    lock_bolt();
}

module lock_bolt() {
    difference() {
        union() {
            hull() {
                translate([0,-4.5/2])    cube([72,4.5,3.5]);
                translate([0,-2/2])    cube([74,2,2.5]);
            }
            translate([0,-8/2])      cube([65-thick,8,5]);
            hull() {
                translate([2, 5,0]) cylinder(r=2, h=1);
                translate([2,-5,0]) cylinder(r=2, h=1);
                translate([4, 5,15]) sphere(4);
                translate([4,-5,15]) sphere(4);
            }
            hull() {
                translate([3,3,8]) cylinder(r=3, h=1);
                translate([-1,3,13]) sphere(3);
                translate([3,3,15]) sphere(3);
            }
        }
        // hole for nail
        translate([0,0,3])
        rotate([0,90,0])
            cylinder(d=2.6, h=80, center=true);
        // hole for nail head + drop-in
            translate([8,-5/2,0.2])      cube([35,5,4]);
            translate([8,-4.5/2,0.2])      cube([35,4.5,6]);
    }
}