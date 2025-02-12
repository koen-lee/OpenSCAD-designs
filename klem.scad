$fn=16;
module klem_omtrek()
{
    
    offset(r=2)
    offset(r=-4)
    offset(r=2)
    union() {
        translate([0,-30])
            square([30,60], center=true);
          
        hull() {
            square([30,30], center=true);
            translate([0,7.5])
                square([60,15], center=true);
        }  
    }
}

module veer_houder() {
    offset(r=-13,$fn=32)
    offset(r=13,$fn=32)
    {
        square([1,50], center=true);
        translate([4,0])
        square([8,16], center=true);
        translate([8,0])
        circle(d=14,$fn=32);
    }
}

module zak_klem1()
{
    union(){
        translate([9,0])
            3d_veer_houder();
        translate([-9,0])
            3d_veer_houder();
        minkowski() {
            sphere(r=0.5, $fn=5);
            union(){                   
                translate([0,20,0])
                linear_extrude(1,center=true)
                    klem_omtrek();
            }
        }
        
        hull()
        {
            translate([-28,34.5,0.7])
                sphere(d=2, $fn=16);
            translate([28,34.5,0.7])
                sphere(d=2, $fn=16);
        }
    }
        
}
module zak_klem2()
{
    union(){
        
        translate([6.5,0])
            3d_veer_houder();
        translate([-6.5,0])
            3d_veer_houder();
        minkowski() {
            sphere(r=0.5, $fn=5);
            union(){                    
                translate([0,20,0])
                linear_extrude(1,center=true)
                    klem_omtrek();
            }
        }
        hull()
        {
            translate([-29,32.7,1])
                sphere(d=2, $fn=16);
            translate([29,32.7,1])
                sphere(d=2, $fn=16);
        }
    }
        
}

module 3d_veer_houder() {
    difference(){
        rotate([0,-90,0])
            minkowski() {
                sphere(r=0.5, $fn=5);
                linear_extrude(1,center=true)
                    veer_houder(); 
            }
        translate([0,0,8.5])
        rotate([0,90,0])
            cylinder(h=20, d=3.5, center=true);            
    }
}

if($preview)
{
rotate([0,90,0])
color("blue")
    cylinder(h=20, d=3, center=true);

r = 11.5;
rotate([r])
translate([0,0,-8.5])
zak_klem1();
rotate([r,180,0])
translate([0,0,-8.5])
zak_klem2();
} else {    
    zak_klem1();        
    translate([50,-5,0])
    rotate([0,0,180])
        zak_klem2();
}