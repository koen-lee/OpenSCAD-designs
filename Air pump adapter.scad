
rotate_extrude()
{
    polygon([
    [16,0],
    [15,20],
    [12,20],
    [9,18],
    [9,0],
    [10.4,0],
    [10.4, 17],
    [14,17],
    [14,0],
    ]);
}

translate([0,12,10])
    rotate([90,0,0])
    cylinder(d=3, h=6, center=true);

translate([0,-12,10])
    rotate([90,0,0])
    cylinder(d=3, h=6, center=true);