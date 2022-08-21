module wire_tray()
{
    radius=450;
    translate([-radius,0,0])
    rotate([0,0,-10])
    rotate_extrude(angle=20, $fa=1)
    {
        translate([radius, 0])
        {
            $fn=32;
            //lower wire
            circle(d=6.06);
            polygon([
                    [-5,-7],
                    [5,-7], 
                    [3.03,-3],
                    [3.03,0],
                    [-3.03,0],
                    [-3.03,-3]               
                ]);
            //upper wire
            translate([6,37.6])
                circle(d=8.08);
        }
    }
}

module mounting(angle)
{    
    radius=450;
    translate([-radius,0,0])
    rotate([0,0,angle])
    translate([radius,0,0])
    {
        translate([0,0,32])
            cube([99,6,3], center=true);
        translate([0,0,43])
            cube([99,6,3], center=true);
    }
}

module blob() {
    radius=450;
    translate([-radius,0,0])
    rotate([0,0,-4])
    rotate_extrude(angle=8, $fa=1)
    {
        translate([radius, 0])
        {
            offset(r=2)
            {
                offset(r=-2)
                polygon([
                    [-7,-5],
                    [7,-5],
                    [6,30],
                    [6,40],
                    [0,60],
                    [-9,60],
                    [-7,40]
                
                ]);
            }
        }
    }
}

module inset() {
    translate([0,0,30])
    rotate([0,90,0])
        cylinder(h=99,d=35, center=true, $fn=64);
    translate([0,0,30+35])
        cube([99,35,70], center=true);    
}


difference(){
    blob();
  %  wire_tray();
    rotate([0,-30,0])
        inset();
    mounting(3.2);
    mounting(-3.2);
}