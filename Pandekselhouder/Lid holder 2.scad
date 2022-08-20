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

module outline()
{
    polygon([
                    [-8,-6],
                    [40,-6],
                    [40,30],
                    [40,60],
                    [6,60],
                    [6,30],
                    [-8,10]
                ]);
}

module blob() {
    radius=450;
    translate([-radius,0,0])
    rotate([0,0,-2])
    rotate_extrude(angle=5, $fa=1)
    {
        translate([radius, 0])
        {
            offset(r=2)
            {
                offset(r=-2)
                outline();
            }
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
        translate([0,0,33])
            cube([99,6,3], center=true);
        translate([0,0,44])
            cube([99,6,3], center=true);
    }
}

module lid()
{
    lid_diameter=250;
    cylinder(h=17,d=lid_diameter);
    translate([0,0,15])
        cylinder(h=20, d1=lid_diameter, d2=30);
    translate([0,0,33])
        cylinder(h=20, d1=30, d2=50);
}

difference(){
    blob();
    wire_tray();
    mounting(2);
  //  mounting(0);
    mounting(-1.2);
    
        rotate([0,0,2])
    translate([13,110,90])
        rotate([0,90,0])
            lid();
}