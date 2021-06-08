// Holes are intended to be filled with ferrules. The ferrule plastic outer diameter matches the conical holes.
// The seeds (large or pilled for the 0.5mm2 variant, raw (basil) for the 0.34 mm2) are sucked to the ferrule end, placed on or in the substrate, release the vacuum.

d_adereindhuls = 2.54; //0.34 mm2 
//d_adereindhuls = 3; //0.5 mm2 
difference(){
    cylinder(r=17, h=10);
    translate([0,0,3])
        cylinder(d=30, h=10);
    for(v=[
        [360*(1/7),10],
        [360*(2/7),10],
        [360*(3/7),10],
        [360*(4/7),10],
        [360*(5/7),10],
        [360*(6/7),10],
        [360*(7/7),10],
        [360*(1/3),4],
        [360*(2/3),4],
        [360*(3/3),3]])
    {
        rotate([0,0,v[0]])
        translate([v[1],0,-0.5])
            cylinder(d1=d_adereindhuls+0.2, d2=d_adereindhuls-0.2, h=4, $fn=64);
    }
        
}