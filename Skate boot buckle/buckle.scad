$fn=128;
module buckle(){
    intersection()
    {
        translate([0,0,80])            
        union() {
            cylinder(r=4.5, h=20);
            translate([0,-4.5,0])
                cube([28,9,20]);
            translate([27.9,-9.5,0])
                cube([28,19,20]);
        }
        
        rotate([90,0,0])
        difference(){
            translate([0,40,0])            
            cylinder(r=60, h=40, center=true);
            translate([0,-10,0])            
                cylinder(r=100, h=41, center=true);
            translate([6,95,0])
            rotate([0,0,-45]){
                cylinder(r=1.4, h=41, center=true);
                translate([10,0,0])
                    cube([20,2.8,41],center=true);
            }
            
        }
    }
}

module belt_node()
{
    translate([-3,0])
    intersection(){
        linear_extrude(height=2.6)
        {
            polygon([
            [0,-9.5],
            [5,-9.5],
            [7,-7],
            [7,7],
            [5,9.5],
            [0,9.5],
            ]);
        }
        rotate([90,0,0])
        linear_extrude(height=20,center=true)
        {
            polygon([
            [0,0],
            [8,0],
            [8,1.1],
            [5,1.2],
            [2,2.6],
            [2.1,1.2],
            [0,1.1],
            ]);
        }
        
        rotate([90,0,90])
        linear_extrude(height=20, center=true)
        {
            polygon([
            [-9.5,0],
            [-9.5,1.1],
            [0,8],
            [9.5,1.1],
            [9.5,0],
            ]);
        }
    }
}

module belt(){
    union(){
        for(i=[0:40])
            rotate([0,i*2,0])
            translate([0,0,90])
                belt_node();
    }
}

//belt_node();
rotate([-90,0,0]){
    rotate([0,-25])
    translate([0,0,65])
    rotate([0,-22])
    translate([0,0,-80])
        buckle();
    belt();
}