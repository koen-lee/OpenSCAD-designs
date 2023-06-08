d_frame = 17.6;
$fn=32;
mount_l = 50;


module torus(inner, thick)
{
    rotate_extrude()
    {
        translate([(inner+thick)/2, 0])
            circle(d=thick);
    }
}

module mount()
{
    
    translate([0,d_frame/2,0])
    rotate([0,90,0])   
    difference() {
        union() {
            cylinder(d=d_frame+5,h=mount_l, center=true);
                
            translate([0,0,-mount_l/2])
                torus(d_frame, 2.5);
            
            translate([0,0,mount_l/2])
                torus(d_frame, 2.5);
        }
        cylinder(d=d_frame,h=51, center=true);
        translate([d_frame/2,0,0])
            cube([d_frame,d_frame,51], center=true);
        
    }
}

module ring(inner, thick, width)
{
    rotate([0,90,0])   
    {
        difference() { 
            cylinder(d=inner+2*thick,h=width, center=true);
            cylinder(d=inner,h=width+1, center=true);
        }
        translate([0,0,width/2])
            torus(inner, thick);
        translate([0,0,-width/2])
            torus(inner, thick);
    }
}

module sp_pt(where)
{
    translate(where)
        sphere(r=1.25, $fn=16);
}
module guard() 
{   
    hull() {
        sp_pt([25,0,0]);
        sp_pt([-25,0,0]);
        sp_pt([30,0,30]);
        sp_pt([-25,0,45]);
    }
    hull() {
        sp_pt([30,0,30]);
        sp_pt([-25,0,45]);
        sp_pt([-10,0,60]); 
        sp_pt([40,0,60]);
    }
    hull() {
        sp_pt([-10,0,60]);
        sp_pt([40,0,60]);
        sp_pt([10,20,65]);
        sp_pt([40,20,65]);
    }
}

difference()
{
    union() {
        mount();
             
        translate([0,1,0])
        rotate([0,0,-5])
            guard();
    }
    
    translate([20,d_frame/2,0])
    ring(d_frame+5, 2, 4);
    translate([-20,d_frame/2,0])
    ring(d_frame+5, 2, 4);
    

    translate([0,d_frame/2,0])
    rotate([0,90,0])   
    {
        cylinder(d=d_frame,h=71, center=true);
        translate([d_frame/2,0,0])
            cube([d_frame,d_frame,71], center=true);
    }
}