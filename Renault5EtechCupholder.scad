$fn=256;
module rounded_rect(w, l, h, r, center=false){
    hull() {
        translate([r,r])
        cylinder(r=r, h=h, center=center);
        translate([w-r,r])
        cylinder(r=r, h=h, center=center);
        translate([w-r,l-r])
        cylinder(r=r, h=h, center=center);
        translate([r,l-r])
        cylinder(r=r, h=h, center=center);
    }
}
thick = 3;
width = 110;
length = 170;
intersection(){
    union(){
        difference() {
        rounded_rect(width, length, thick, 7 );
            translate([thick, thick,-0.05])
        rounded_rect(width-2*thick, length-2*thick, thick+0.1, 7-thick );
        }
        translate([(70+thick)/2,25,35])
        rotate([20,0,0])
        difference(){
            union(){
                cylinder(d1=70+thick, d2=80+2, h=50, center=true);
                translate([0,0,-45])
                cylinder(d=70+thick, h=100, center=true);
            }
            cylinder(d1=70, d2=79.5, h=50+0.1, center=true);
            translate([0,0,-45])
            cylinder(d=70, h=100+0.1, center=true);
        }
    }
    translate([0,0,400])
    cube(800, center=true);
}
    