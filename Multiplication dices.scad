module die() {
    difference(){
        intersection(){
            cube(30, center=true);
            sphere(21,$fn=64);
        }

        number("10");
        rotate([180,0,0])
        number("1");
        rotate([90,0,0])
        number("2");
        rotate([0,90,0])
        number("3");   
        rotate([0,-90,0])
        number("4");   
        rotate([-90,0,0])
        number("5");
    }
}

module number( num )
{
    translate([0,0,14.5])
        linear_extrude(1)
        text(num,size=17,halign="center", valign="center");
}

rotate([37,37,0])
{
    die();
}