union(){
    difference(){
        cylinder(d=100,h=20, $fn=2*7);
        translate([0,0,1])
            cylinder(d=100-3,h=20, $fn=2*7);
    }


    dow = [
    "Ma",
    "Di",
    "Wo",
    "Do",
    "Vr",
    "Za",
    "Zo",
    ];

    for(i=[0:6])
    {
        rotate([0,0,i*360/7])
        {
            translate([-0.5,0,0.5])
                cube([1,48,19]);
            translate([0,-40,0.1])
                linear_extrude(1.5)
                    text(dow[i],halign="center");
            
            translate([0,-47.5,5])
                rotate([90,0,0])
                    linear_extrude(1.5)        
                        text(dow[i],halign="center");
        }     
    }
    rotate([0,0,-360/28])
        cylinder(d=10, h=25, $fn=7);
}
translate([110,0,0])
{
    difference()
    {
        cylinder(d=100, h=1.5, $fn=14);  
        rotate([0,0,-360/28])          
            cylinder(d=10.1, h=25, $fn=7, center=true);
        translate([0,0,-1])
        difference()
        {
            cube(70);
            rotate([0,0,-360/7])                
            cube(80);
        }
        //eye
        translate([-20,20,1])
            cylinder(d=10,h=4,$fn=129);
        
        l=[0,5,8,5,5,8,5];
        o=[0,-1,0,1,-1,0,1];
        // cut out
        for(i=[1:6])
        {
            rotate([0,0,i*360/7-360/14])
            {
                translate([o[i],7,0])
                    cube([l[i],1.1,9], center=true);
            }     
        }
        rotate([0,0,3*360/7])
        {
            translate([0,7,0])
                cube([1,14,9], center=true);
            translate([2,10,0])
                cube([1,7,9], center=true);
            translate([-2,10,0])
                cube([1,7,9], center=true);
        }  
        rotate([0,0,6*360/7])
        { 
            translate([2,10,0])
                cube([1,7,9], center=true); 
        }  
        
        rotate([0,0,0*360/7])
        { 
            translate([-2,10,0])
                cube([1,7,9], center=true); 
        }  
    }
}