$fn=34;
difference()
{
    union()
    {
        difference()
        { 
            cylinder(d=34, h=7, center=true);    
            cylinder(d=27.5, h=80, center=true);
            
            translate([13,0,0])
                cube([7,0.5,8], center=true);
            translate([15.6,1,0])
                cube([3,0.5,8], center=true);
            translate([15.6,-1,0])
                cube([3,0.5,8], center=true);
            translate([-15.6,0,0])
                cube([6,0.5,8], center=true);
            
        }

        for(i=[90:180:360])
        {    
            rotate([0,0,i])
            translate([10.5,0,0])
            cube([7,7,7], center=true);
        }
    }

    rotate([90,0])
        cylinder(h=80,d=2, center=true);
}