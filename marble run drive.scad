module profile() {
    halfpoints = [[0,0],[2,0], [1.8,2],[1.5,3], /*[3,3]*/,[3,4],[0,4]];
    polygon(halfpoints);
    mirror([0,1])
    polygon(halfpoints);    
}

module drive_pulley() {
    difference(){
        union() {
            rotate_extrude(convexity=10, $fn=64)
                translate([4,0]) profile();
            translate([1.5,0,0])
                cube([2,8,8], center=true);
            translate([-1.5,0,0])
                cube([2,8,8], center=true);
            
            translate([6,0,3.9])
                cylinder(h=3, d=2, $fn=8);
        }
        cylinder(h=10, d=3.5, center=true, $fn=16);
    }
}

module driven_pulley() {
    d=100;
    difference(){
        union() {
            rotate_extrude(convexity=10, $fn=64)
                translate([d/2,0]) profile(); 
            cube([4,d,8], center=true);
            cylinder(d=15,h=8, center=true);
             
        }
        cube([1,d/2,9], center=true);
        cube([10,4,9], center=true);
        cube([4,10,9], center=true);
            
    }
}

translate([20,20,0])
    drive_pulley();
driven_pulley();