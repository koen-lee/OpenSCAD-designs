module half_inner_clip(){
      
    linear_extrude(3.5, center=true)
    {
        polygon([
            [0,0],
            [0,21],
            [14.5,21.01],
            [14.5,0]
        ]);
    }
    linear_extrude(6, center=true)
    {
        polygon([
            [0,0],
            [0,27],
            [12,27],
            [12,21],
            [8.5,21], 
            [7.5,20], 
            [11,7], 
            [15,0]
        ]);
    }
}
    
module inner_clip() {
    union(){
        half_inner_clip();
        
    translate([0.01,0,0])
        mirror([1,0,0])
            half_inner_clip();
    }
}

w=30;
h=8;
l=26;
difference() {
    union() {
        translate([0,13,0])
            cube([w,l,h], center=true); 
        translate([w/2,l/2,0])  
        scale([0.3,1,1])     
            rotate([90,0])
                cylinder(d=h,h=l, center=true, $fn=16);        
        translate([-w/2,l/2,0]) 
        scale([0.3,1,1])
            rotate([90,0])
                cylinder(d=h,h=l, center=true, $fn=16);
    }
    translate([0,-0.01,0])
        inner_clip();
    translate([w/1.8,11,0])
        scale([10,17,h+1])
            cylinder(d=1,h=1, center=true, $fn=16);        
    translate([-w/1.8,11,0])
        scale([10,17,h+1])
            cylinder(d=1,h=1, center=true, $fn=16);
    
    translate([0,l-6,0]) 
            cylinder(d=5,h=h+1, center=true, $fn=16);

    //filament joiner holes
    translate([w/2.1,l+0.1,0])
            rotate([90,0])
                cylinder(d=1.8, h=4, $fn=16);
    translate([-w/2.1,l+0.1,0])
            rotate([90,0])
                cylinder(d=1.8, h=4, $fn=16);
    
/*
    translate([0,0,100])
            cube([200,200,200], center=true);/* */ 
}
