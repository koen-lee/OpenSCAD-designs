z = [0,0,1];
$fn=60;
module rotor()
{
    difference(){
        union(){
            difference(){
                cylinder( d=100, h=20);
                 
                translate(5*z)
                    cylinder( d=90, h=20);
                translate(2*z)
                    cylinder( d=9, h=20, $fn=6);
                translate(-2*z)
                    cylinder( d=6, h=20, $fn=60);
                
                
                translate([45,0,5])
                    cylinder( d=5, h=10);
                translate([-45,0,5])
                    cylinder( d=5, h=10);
            }
            translate([45,0,15])
                cylinder( d=5, h=5);
            translate([-45,0,15])
                cylinder( d=5, h=5);
            
         for(i=[0:120:360])
            {
                rotate(i*z)
                    translate([12,0,4])
                        cylinder(d=5,h=5);
            }
        }
        translate([45,0,-5])
            cylinder( d=2, h=50);
        translate([-45,0,-5])
            cylinder( d=2, h=50);
        
        
       
    }
}

module inner_idler()
{
    difference() {
        union(){
            difference(){
                cylinder(d=60, h=15);
                cylinder(d=50, h=60, center=true);
                
                translate([30,0,5])
                    cylinder( d=5, h=5);
                translate([-30,0,5])
                    cylinder( d=5, h=5);
            }

            translate([30,0,0])
                cylinder( d=5, h=5);
            translate([-30,0,0])
                cylinder( d=5, h=5);

            translate([30,0,10])
                cylinder( d=5, h=5);
            translate([-30,0,10])
                cylinder( d=5, h=5);

            for(i=[0:120:360])
            {
                rotate(i*z)
                    translate([12,0,0])
                        cylinder(d=5,h=5);
            }
        }
        translate([30,0,-5])
            cylinder( d=2, h=50);
        translate([-30,0,-5])
            cylinder( d=2, h=50);
        
    }
}



color("blue")
    rotate(360*$t*z)
        rotor();

color("magenta")

    translate([7,0,5.01])
    {
        rotate(360*$t*z)
            inner_idler();
    }