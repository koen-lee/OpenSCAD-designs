$fn=128;
d_aa = 14;
h_aa = 50;
d_d = 33;
h_d = 61;
z=[0,0,1];

module AA() {
    color("blue")
    cylinder(h=h_aa-1, d=d_aa);
    cylinder(h=h_aa, d=4);
}
intersection(){
    union() {
        difference() {
            cylinder(h=h_d-2, d = d_d);
            translate(z) cylinder(h=h_d, d=d_d-1);
            for(r=[0:90:360])
                rotate(r*z)
                    translate([0,d_d/2]) 
                        cube([1,3,3],center=true);
            
            cylinder(h=h_d-2, d = d_d-7, center=true);
        }
        difference(){
            intersection() {
                cylinder(h=h_d-2, d = d_d);
                rotate(45*z)
                {
                    cube([0.7,d_d,h_d*2],center=true);
                    cube([d_d,0.7,h_d*2],center=true);
                }
            }
            translate(z*(h_d-h_aa-0.5)) AA();
        }
    }
    cylinder(h=h_d, d1=d_d-2, d2=d_d+h_d);

}
//translate(z*(h_d-h_aa)) AA();
