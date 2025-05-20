$fn=360;
z=[0,0,1];

module roller(){
    difference(){
        union(){
            intersection(){
                cylinder(h=10, r=13, center=true);
                translate(-7*z)cube(30);
            }
            cylinder(h=10, r=2.5, center=true);
        }
        cylinder(h=12, r=1.2, center=true);
        
        cylinder(h=6, r=11, center=true);
        translate([-5,-5])
            cube([10,10,12],center=true);
    }
}

module mount(){
    difference(){
        union(){
            translate([4,2])
                cube([10, 5.5,4.5], center=true);
            translate(z*1.75)
                cylinder(h=1.2, r=3, center=true);
            translate(-z*1.75)
                cylinder(h=1.2, r=3, center=true);
        }
        cylinder(h=12, r=1.3, center=true);
        
        translate([4,2])
            cube([11, 2.5,2.5], center=true);
    }
}

if($preview){
    color("yellow")
        roller();

    color("green")
        mount();

    color("blue")
        cylinder(h=12, r=1.2, center=true);
} else {
    translate(z*5)
        roller();
    translate([-10,0,9])
    rotate([0,90,0])
    mount();
}