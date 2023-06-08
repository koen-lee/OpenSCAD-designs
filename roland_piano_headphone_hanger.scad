module shape()
{
    polygon([
                [5,5],
                [100,5],
                [100,10],
                [40,10],
                [40,20],
                [39,20],
                [39,10],
                [5,10],
                [0,20],
                [0,20]
                ]);
}

difference(){
    union() {
        linear_extrude(5, center=true)
        {
            offset(r=-5)
            offset(r=10)
            {
                shape();
            }
        }
        
        linear_extrude(6, center=true)
        {
            offset(r=-5.5)
            offset(r=10)
            {
                shape();
            }
        }

        translate([50,2,3])
        {
            rotate([-90,0,0])
            scale([90,8,4])
            sphere(d=1, $fn=64);
        }
    }
    translate([95,8,0])
    {
        cylinder(d=4, h=20, center=true);
    }
    translate([80,8,0])
    {
        cylinder(d=4, h=20, center=true);
    }
    
}        