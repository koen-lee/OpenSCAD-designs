module leg() {
    linear_extrude(height=3, center=true)
    {
        polygon([
        [10,50],
        [14,0],
        [17,2],
        [17,3],
        [15.5,3],
        [15.5,6],
        [18,6],
        [18,7],
        [15,8],
        [12,40],
        [15,45],
        [15,46],
        [11.5,46],
        [11.5,47],
        [12.5,47],
        [12.5,48],
        ]);    
    }
}

leg();
mirror([-1,0,0])
    leg();
translate([0,20,0])
    cube([27,3,3], center=true);

translate([40,0,0])
{
    leg();
    mirror([-1,0,0])
        leg();
    
    translate([0,23,0])
        cube([27,3,3], center=true);
}