$fn=128;
module base() {
    translate([-(135-68)/2,0,0]) cylinder(r=68/2, h=30, center=true);
    translate([0,0,0]) cube([135-68,68,30], center=true);
    translate([(135-68)/2,0,0]) cylinder(r=68/2, h=30, center=true);
    
}

difference(){
    scale([1.03,1.03,1])
        base();
    translate([0,0,2])
        base();
    translate([60,0,0])
        cube([20,10,7],center=true);
}