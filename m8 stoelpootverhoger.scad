$fn=32*($preview?1:2);
module slotbout_m8()
{
    color("gray")
    union()
    {
        intersection()
        {
            translate([0,0,20])
                sphere(d=40);
            cylinder(d=20.5, h=5);
            
            cylinder(d1=29, d2=19, h=5);
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
            sphere(d=43);
        cylinder(d=24, h=12, center=true);
    }
    
    slotbout_m8();
    translate([0,0,3.2])
        cylinder(d1=15,d2=25, h=5);
    $n=7;
    for(i=[0:(360/$n):360])
    {
        rotate([0,0,i])
        translate([0, -0.5,3])
            cube([30,1,10]);
    }
    translate([0,0,4])
        cylinder(h=4,d=20.5,$fn=7);
    
    if($preview)
        translate([0,0,-5])cube(20);
    
}
