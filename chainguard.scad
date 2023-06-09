d_frame = 17.6;
$fn=32;
mount_l = 80;


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
    l_half = mount_l/2;
    hull() {
        sp_pt([l_half,0,0]);
        sp_pt([-l_half,0,0]);
        sp_pt([l_half+5,0,30]);
        sp_pt([-l_half,0,55]);
    }
    hull() {
        sp_pt([l_half+5,0,30]);
        sp_pt([-l_half,0,55]);
        sp_pt([15-l_half,0,70]); 
        sp_pt([l_half+25,0,70]);
    }
    hull() {
        sp_pt([15-l_half,0,70]);
        sp_pt([l_half+25,0,70]);
        sp_pt([-l_half+35,20,75]);
        sp_pt([l_half+25,20,75]);
    }
}

difference()
{
    union() {
        mount();
             
        translate([0,1,0])
        rotate([0,0,-3])
            guard();
    }
    
    translate([-mount_l/2+10,d_frame/2,-1])
    ring(d_frame+5, 2, 4);
    translate([mount_l/2-10,d_frame/2,-1])
    ring(d_frame+5, 2, 4);
    

    translate([0,d_frame/2,0])
    rotate([0,90,0])   
    {
        cylinder(d=d_frame,h=mount_l+10, center=true);
        translate([d_frame/2,0,0])
            cube([d_frame,d_frame,mount_l+10], center=true);
    }
}