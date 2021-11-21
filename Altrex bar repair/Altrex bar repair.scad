
difference()
{
    union(){
        hull()
        {
            translate([-2,0,0])
            cylinder(d=10.1, h=4);
            translate([2,0,0])
                cylinder(d=10.1, h=4);
        }
        hull()
        {            
            translate([-2,0,0])
                cylinder(d=15, h=1);
            translate([2,0,0])
                cylinder(d=15, h=1);
            translate([0,23,0])
                cylinder(r=6,h=1);

        }
    }
    cylinder(d=8.1, h=20, center=true);
    translate([0,23,0])
        cylinder(r=2,h=20, center=true);
        
}

translate([22,0,0])
difference()
{
    union(){
        hull()
        {            
            translate([-2,0,0])
                cylinder(d=15, h=1);
            translate([2,0,0])
                cylinder(d=15, h=1);
            translate([0,23,0])
                cylinder(r=6,h=1);
        }
    }

    hull()
    {
        translate([-2,0,0])
        cylinder(d=10.2, h=4, center=true);
        translate([2,0,0])
            cylinder(d=10.2, h=4,center=true);
    }

    translate([0,23,0])
        cylinder(r=2,h=20, center=true);
        
}
