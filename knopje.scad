module m5_nut()
{
    cylinder(d=9.5, h=5, $fn=6);
}

$fn=128;

difference(){
    rotate_extrude()
    {
        intersection(){
            difference() {
                circle(r=20);
                translate([28,0])
                circle(r=20);
            }
            square([13.5,21]);
        }
    }
    cylinder(h=18.5, d=6);
    translate([0,0,5])
        m5_nut();
    
    cylinder(h=4, d1=13,d2=5);
}