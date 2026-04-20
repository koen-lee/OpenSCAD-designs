d=0.9;
for(x=[-8:8])
    for(y=[0:25])
    {
        translate([x*1.5,y*sqrt(3)/2])
            cylinder(h=1, d=d, $fn=6);
        
        translate([x*1.5 + 0.75,(y + 0.5)* sqrt(3)/2])
            cylinder(h=1, d=d, $fn=6);
    }