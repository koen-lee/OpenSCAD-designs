$fa=5;

// Do not ask me to explain this it took far too much fiddling :D
module rtroch_b(r1=30, n=5, step=0, mstep=64, arr=[])
assign(r2 = ((n+1)/(n-1)) * (r1 / (n+1)))
assign(a1=(step*360)/mstep, a2=(step*360*r1)/(mstep*r2)) {
	if(step < mstep) {
		rtroch_b(r1, n, step+1, mstep, concat(arr, [
				((r1)*[sin(a1),cos(a1)]) + r2*[-sin(a2),cos(a2)]
			]));
	}
	else
	{
		echo("r2b",r2);
		polygon(arr);
	}
}

nA = 4;
nB = nA-1;
rotate([0,0,-(20*360*$t)/nA]) difference() {	
	cylinder(r=45, center=true, h=99);
	linear_extrude(100, center=true, convexity=3, twist = nB*3)
        offset(r=1.5, $fn=32)
            rtroch_b(n=nA);
}

color("yellow")
translate([0,10,0]) rotate([0,0,-(20*360*$t)/nB]) difference() {
	linear_extrude(100, center=true, convexity=4, twist=nA*3)
        offset(r=1, $fn=32) 
            rtroch_b(n=nB, r1=30-10);
}