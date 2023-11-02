module names() {
    color("black")
    linear_extrude(2)
    {
        h=24;
        off = 4
        ;
        indent = 0;
        translate([indent,3*h+off])
        text("Koen", size=20, font="Wilgenrijk");
        translate([indent,2*h+off])
        text("Wendy", size=20, font="Wilgenrijk");
        translate([indent,1*h+off])
        text("Marit", size=20, font="Wilgenrijk");
        translate([0,0])
        text("van Leeuwen", size=24, font="Wilgenrijk");
    }
    color("grey")
    linear_extrude(1)
        offset(-10)
        offset(20)
        {
            difference()
            {
                square([180,100]);
                translate([80,20])
                    square( [180,100]);
            }
        }
}

module number() {

    color("darkgrey")
    linear_extrude(2)
        translate([40,15])
        text("17", size=80, font="Wilgenrijk", halign="center");
    color("teal")
        linear_extrude(1)
        difference() {
            offset(10)
                square(80);
                
            circle(r=2);
            translate([80,0])
            circle(r=2);
            translate([0,80])
            circle(r=2);
            translate([80,80])
            circle(r=2);
        }

}

translate([100.2,40.2])
number();
names();