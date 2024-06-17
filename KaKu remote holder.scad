module remote()
{
    //30x110x15;
    scale([1,15/8,1])
    hull(){
        translate([-11,0,0])
            cylinder(r=4.1, h=110);
        translate([ 11,0,0])
            cylinder(r=4.1, h=110);
    }
}

difference() {
    scale([1.1, 1.1,1])
        remote($fn=32);
    translate([0,0,1])
        remote($fn=32);
    translate([0,107,99])
        cube([200,200, 200], center=true);
    
    translate([0,-8,97])
        cube([40,3, 4], center=true);
}
        