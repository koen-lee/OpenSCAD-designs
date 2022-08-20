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
            circle(d=6.06);
            translate([0,-3])
                square(6.06,center=true);
            translate([6,38.6])
                circle(d=8.08);
        }
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
                    [-10,-6],
                    [8,-6],
                    [6,30],
                    [6,60],
                    [-10,60]
                
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

module mounting(angle)
{    
    radius=450;
    translate([-radius,0,0])
    rotate([0,0,angle])
    translate([radius,0,0])
    {
        translate([0,0,33])
            cube([99,6,3], center=true);
        translate([0,0,44])
            cube([99,6,3], center=true);
    }
}

difference(){
    blob();
    wire_tray();
    rotate([0,-30,0])
        inset();
    mounting(3.2);
    mounting(-3.2);
}