$fn=32;
module band() {
    h=10;
    d=2;
    rotate_extrude($fn=360){
        translate([50,0]){
            circle(d=d);
            translate([0,h/2])
                square([d,h], center=true);        
            translate([0,h])
                circle(d=d);
        }
    }
}

module button( txt, w ){
    h=5; d=3;
    difference() {
        linear_extrude(5)
            hull() {
                circle(d=d);
                translate([0,h])
                    circle(d=d);
                translate([w,h])
                    circle(d=d);
                translate([w,0])
                    circle(d=d);
            }
        translate([0,0,4])
            linear_extrude(2, convexity=10)
                text(txt, size=h);
    }
}

module unit() {
    hull(){
        scale([10,1,1]){
            sphere(d=3);
            translate([0,10,0])
                sphere(d=3);
            translate([0,10,15])
                sphere(d=3);
            translate([0,0,15])
                sphere(d=3);
        }
    }    
}

module lens() {
    d=15;
    intersection()
    {
        cylinder(h=5, d=d);
        translate([0,0,-58.5])
            sphere(60, $fn=360);
    }
    difference() {
            cylinder(h=1.5, d=d);
            cylinder(h=20, d=d-2, center=true);
    }
}

difference() {
    union() {
        translate([0,45])
            unit();
        band();
    }
    translate([0,43,10])
    rotate([-45,0,0])
        cube([25, 25, 0.5], center=true);
}
translate([11,53,13]) rotate([0,0,180])
    button("on", 8);
translate([-1,53,13]) rotate([0,0,180])
    button("off", 8);

translate([0,56,8])
rotate([-90,0,0])
lens();