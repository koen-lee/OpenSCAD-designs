cable_thickness = 7.5;

module bar(iter){
    translate([iter,-0.5,0])
        cube([0.1,1,(cos(175*iter)+1)/2]);
}

module cosine_ramp() {
    for(i=[-1:0.1:0.9])
        hull(){
            bar(i);
            bar(i+0.1);
        }
}

module pillar(x, y, z)
{
  translate([x,y*cos(36*x)/2,0])
        cylinder(d=0.8, h=z, $fn=6);
   
}

module cosine_curve(x, y, z) {
    for(i=[-x:0.4:x])
        hull(){
            pillar(i,y,z);
            pillar(i+0.4,y, z);
        }
}

intersection() {
    scale([60,20,cable_thickness])
        cosine_ramp();
    difference(){
        union() {
            cosine_curve(70, 15, cable_thickness);
            linear_extrude(10)
                polygon([[0,8],[1.5, 4], [2.5, -1], [-2.5,-1],[-1.5, 4]]);
        }
        translate([0,0,cable_thickness])
            cube([cable_thickness-1,60,5], center=true);
        translate([0,0,cable_thickness/2+0.281])
        rotate([90,0,0])
            cylinder(d=cable_thickness, h=30, center=true, $fn=32);
    }
}