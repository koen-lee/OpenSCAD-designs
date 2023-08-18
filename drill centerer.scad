difference(){
    intersection(){
        cylinder(d=105.5, h=20, $fn=128);
        cylinder(d=120,   h=20, $fn=5);
    }
    cube([10,10,50], center=true);
    translate([0,0,1])
    difference(){
        
        intersection(){
            cylinder(d=105.5-2, h=20, $fn=128);
            cylinder(d=120-2,   h=20, $fn=5);
        }
        cube([13,13,50], center=true);
    }
    for(i=[0:72:360])
        rotate([0,0,i])
            translate([-30,0,0])
                cylinder(d=30, h=50, center=true);
}