module pickup() {
    length=110;
    width=4;
    difference() {
        union(){
            cube([width,length,width], center=true);
            
            difference() {
                translate([10/2,length/2,0])
                    cylinder(d=10+width, h=width,$fn=32,center=true); 
                translate([10/2,length/2,0])
                    cylinder(d=10-width, h=width+1,$fn=32,center=true);
                translate([10/2,length/2-8,0])
                    cube([10-width,10+width+1,width+1],center=true);
            }
             
            translate([10-1,length/2-6,0])
                cylinder(d=width-1, h=width,$fn=32,center=true); 
            
            translate([0,-length/2,0.5])
                cube([width+2,1,width+1],center=true);
            
            translate([0,-length/2+3,0])
                scale([1,0.7,1])
                cylinder(d=width+1, h=width,$fn=32,center=true);
        }
        
        translate([0,-length/2+4,0])
                scale([0.3,2,1.1])
                cylinder(d=width, h=width+1,$fn=32,center=true);
        }
    
}
 

//55x40x2

module mesh() {

    difference() {
        thickness = 1;
        size_x=55;
        size_y=40;
        holes_x=9;
        holes_y=7;
        
        hole_x = (size_x - thickness) / holes_x - thickness;
        hole_y = (size_y - thickness) / holes_y - thickness;
        echo([hole_x,hole_y]);
        cube([55,40,3]);
        for(dx=[0:holes_x-1]) {
            for(dy=[0:holes_y-1]) {
                translate([thickness + dx * (hole_x+thickness),         thickness + dy * (hole_y+thickness),-1])
                    cube([hole_x, hole_y, 100]);
            }
        }
        translate([thickness, thickness,2])
        cube([size_x-2*thickness,size_y-2*thickness,100]);
    }
}

//translate([-10,0,2])
pickup();
//mesh();
