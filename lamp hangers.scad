offcenter = 15;

$fn=32;

difference()
{
    union() {
        translate([-offcenter-3,-1,-offcenter-3])
            cube([2*offcenter+6,5,77+3*offcenter+3]);
        translate([-2*offcenter-3,-1,77-3])
            cube([2*offcenter,5,2*offcenter+3]);
    }

    //lamp
    translate([-25.5/2-offcenter,-5,0])
        cube([25.5, 10, 77]);

    // cable guide
    rotate([-90,0,0])
    rotate_extrude(angle=180.1){
        translate([offcenter,0,0])
            circle(r=2);
    }

    linear_extrude(height=77.1){
        translate([offcenter,0,0])
            circle(r=2);
    }

    translate([0,0,77])
    rotate([-90,-90.1,0])
    rotate_extrude(angle=90.2){
        translate([offcenter,0,0])
            circle(r=2);
    }

    translate([0,0,77+2*offcenter])
    rotate([-90,90,0])
    rotate_extrude(angle=90.1){
        translate([offcenter,0,0])
            circle(r=2);
    }
}