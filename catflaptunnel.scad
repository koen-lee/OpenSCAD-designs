width  = 157;
height = 165.5;
r1     =   2;
r2     =  30;
thick  = 1.2;
h      =  9;

$fn=64;
module shape() {
    hull(){
        for(m=[0:1])
        mirror([m,0,0])
        {
            translate([(width/2)-r1,165-r1])
                circle(r=r1);
            translate([(width/2)-r2,r2])
                circle(r=r2);
        }
    }
}



    hull(){
        linear_extrude(h+thick, convexity=4)
        {
            offset(-2*thick)
            shape();
        }
