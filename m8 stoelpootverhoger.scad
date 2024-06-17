$fn = 32;
module slotbout_m8()
{
    color("gray")
    union()
    {
        intersection()
        {
            translate([0,0,20])
                sphere(d=40);
            cylinder(d=20, h=5);
            
            cylinder(d1=29, d2=19, h=5);
            cylinder(d1=17.5, d2=22, h=6);
        }
        translate([0,0,6])
            cube([8,8,8], center=true);
        translate([0,0,5])
            cylinder(d=8, h=100);
    }
}

difference(){
    intersection()
    {
        translate([0,0,20])
            sphere(d=42);
        cylinder(d=22, h=12, center=true);
    }
    
    slotbout_m8();
    translate([0,0,3.2])
        cylinder(d1=15,d2=25, h=5);
    for(i=[0:(360/7):360])
    {
        rotate([0,0,i])
        translate([-0.5, 0,3])
            cube([1,30,10]);
    }
    if($preview)
        cube(20);
    
}
