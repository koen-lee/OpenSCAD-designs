module skate_model()
{
    intersection(){
        union(){
            cylinder(r=8, h=430);
            translate([0,-2])
                cube([28,4,430]);
        }
        union(){
            translate([0,10,0])
            rotate([90,0,0])
            linear_extrude(height=20)
            polygon([
                [-10,0],
                [0,0],
                [10,5],
                [20,15],
                [28,28],
                [28,430],
                [15,430],
                [0,420],
                [-10,380],
            ]);
            
        }
    }
}

skate_model();