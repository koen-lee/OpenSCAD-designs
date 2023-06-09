
rotate_extrude()
{
    polygon([
    [15.5,0],
    [14,20],
    [9,20],
    [9,0],
    [10.4,0],
    [10.4, 17],
    [12,17],
    [13,0],
    ]);
}

translate([0,12,10])
    rotate([90,0,0])
    cylinder(d=3, h=4, center=true);

translate([0,-12,10])
    rotate([90,0,0])
    cylinder(d=3, h=4, center=true);