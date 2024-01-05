
module wire_tray()
{
    radius=450;
    translate([-radius,0,0])
    rotate([0,0,-10])
    rotate_extrude(angle=20, $fa=1)
    {
        translate([radius, 0])
        {
            $fn=64;
            //lower wire
            circle(d=6.09);
            polygon([
                    [-5,-7],
                    [5,-7], 
                    [3.03,-3],
                    [3.03,0],
                    [-3.03,0],
                    [-3.03,-3]               
                ]);
            //upper wire
            translate([6.04,37.6])
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

module outline()
{
    polygon([
                    [-7,-5],
                    [38,-5],
                    [38,30],
                    [38,60],
                    [14,60],
                    [14,39],
                    [8,38],
                    [-7,10]
                ]);
}

module blob() {
    radius=450;
    translate([-radius,0,0])
    union(){
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
}

module lid()
{
    $fn=64;
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
  //  mounting(2);
  //  mounting(0);
    mounting(-1.2);
    
        rotate([0,0,2])
    translate([13,110,90])
        rotate([0,90,0])
            lid();
    translate([35,-20,-5])
        rotate([45,0,0])
            cube([50,50,50],center=true);
    
    translate([35,-20,90])
        rotate([45,0,0])
            cube([50,50,50],center=true);
    translate([35,29,90])
        rotate([45,0,0])
            cube([50,50,50],center=true);
    translate([0,46,50])
        rotate([45,0,0])
            cube([50,50,50],center=true);
    translate([5,40,65])
        rotate([45,0,-45])
            cube([50,50,50],center=true);
    
    
}