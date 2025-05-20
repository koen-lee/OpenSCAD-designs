extraheight = 7;
difference(){
    union(){
        rotate([90]) translate([-25,-2])
        linear_extrude(30, center=true){
            polygon([[0,-extraheight],[50,-extraheight],[50,17], [0,7.5]]);
        }
    }
    translate([0,0,15])
        cube([45,25,30], center=true);
    
    translate([10,0,16])
        cube([45,8,30], center=true);
}

        hull(){
            cylinder(h=6.5, d=10.1, $fn=8);
            cylinder(h=7, d=9, $fn=8);
        }