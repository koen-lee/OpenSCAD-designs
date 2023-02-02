union(){
    difference(){
        cylinder(d=100,h=20, $fn=2*7);
        translate([0,0,2])
            cylinder(d=100-4,h=20, $fn=2*7);
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
            translate([0,-40,1])
                linear_extrude(1.5)
                    text(dow[i],halign="center");
            
            translate([0,-47.5,5])
                rotate([90,0,0])
                    linear_extrude(2)        
                        text(dow[i],halign="center");
        }     
    }
    cylinder(d=10, h=25, $fn=7);
}
translate([110,0,0])
{
    difference()
    {
        cylinder(d=100, h=2, $fn=14);            
        cylinder(d=10.1, h=25, $fn=7, center=true);
        translate([0,0,-1])
        difference()
        {
            cube(70);
            rotate([0,0,-360/7])
                
            cube(80);
        }
        
        
        translate([-20,20,-1])
            cylinder(d=10,h=4,$fn=129);
    }
}