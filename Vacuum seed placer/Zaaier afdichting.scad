difference(){
    union() {
        minkowski(){
            cube([30,50,1]);
            cylinder(h=1,r=2, $fn=16);
        }
        translate([15,25,1.9999])
            cylinder(h=2,d1=29.9, d2=29.7);
    }
    translate([15,25,1.9999])
    {
        cylinder(h=3,d=28);
        cube([19,19,19],center=true);
    }
}