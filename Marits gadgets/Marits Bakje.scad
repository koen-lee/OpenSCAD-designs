module rounded_cube(size,r) {
    union()
    {
        height = size[2];
        echo(height);
        translate([r,r,0])
            cylinder(h=height, r=r, $fn=32);
        translate([size[0]-r,r,0])
            cylinder(h=height, r=r, $fn=32);
        translate([size[0]-r,size[1]-r,0])
            cylinder(h=height, r=r, $fn=32);
        translate([r,size[1]-r,0])
            cylinder(h=height, r=r, $fn=32);
        translate([r,0,0])
            cube([size[0]-2*r, size[1], size[2]]);
        translate([0,r,0])
            cube([size[0], size[1]-2*r, size[2]]);
    }
}
module box() {
    union() {
        w=100;
        d=55;
        h=70; 
        th2 = 0.8; //thickness outside
        
        difference() {
            rounded_cube([w,d,h],3);
            translate([th2,th2,1.2])
                rounded_cube([w-2*th2,d-2*th2,h],3);
        }
    }
}
module lid() {
    union() {
        w=110;
        d=65;
        h=15; 
        th2 = 0.8; //thickness outside
        
        difference() {
            rounded_cube([w,d,h],3);
            translate([th2,th2,1.2])
                rounded_cube([w-2*th2,d-2*th2,h],3);
        }
    }
}

module heart() {
    linear_extrude(1,center=true)
        text("♥",7, "Lucida Sans Unicode:style=Regular",halign="center", valign="center");
}

box();
translate([0,70,0])
lid();

translate([50,55,40])
    cube([5,5,15]);

translate([25,-0.3,30])
scale([5,2,5]) rotate([90,0,0])heart();

translate([75,-0.3,30])
scale([5,2,5]) rotate([90,0,0])heart();


translate([25, 55.3,20])
scale([3,2,3]) rotate([90,0,0])heart();

translate([75, 55.3,20])
scale([3,2,3]) rotate([90,0,0])heart();


translate([-0.3,27.5,30])
scale([2,5,5]) rotate([90,0,90])heart();

translate([100.3,27.5,30])
scale([2,5,5]) rotate([90,0,90])heart();
