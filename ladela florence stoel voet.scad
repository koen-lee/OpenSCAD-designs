extraheight = 7;
difference(){ 
    hull(){
        rotate([90]) translate([-25,-2])
        linear_extrude(30, center=true){
            polygon([[3,-extraheight],[50,-extraheight],[50,17], [0,7.5]]);
        }        
        //bottom
        translate([1.5,0,-1.5-extraheight])
            cube([47-1,30-1,3], center=true);
    }
    rotate([90]) translate([-25,-4.5])
    linear_extrude(25, center=true){
        offset(r=-2.5)
        polygon([[3,-extraheight],[50,-extraheight],[50,100], [-2,15]]);
    }
        
    translate([10,0,16])
        cube([45,8,30], center=true);
    translate([10,0,16])
        rotate([45])
            cube([45,11,11], center=true);
    if( $preview){
    translate([0,100])
    cube(200, center=true);
    }
}
//pin
difference() {
    translate([0,0,-extraheight-2])
    {
        hull(){
            cylinder(h=8.5+extraheight+2, d=10.1, $fn=8);
            cylinder(h=9+extraheight+2, d=9, $fn=8);
        }
        cylinder(h=2, d1=16,d2=10, $fn=8);
        cylinder(h=3, d1=13,d2=10, $fn=8);
        
        translate([0,7,0])
            cube([3,6,extraheight+2]); 
        translate([0,-7-6,0])
            cube([3,6,extraheight+2]);
    }
    cylinder(h=100, d=6, $fn=8, center=true);
}