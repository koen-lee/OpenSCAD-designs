// Requires 'concat' builtin.  If you don't have it, go to
// http://www.openscad.org/downloads.html and get a development snapshot.
//
// Totally worth the trouble.  You can now make a procedural polygon
// in one shot, instead of unioning n 3d objects!

// How large an angle is length l along a curve of radius r?
function l2a(l, r) = (360*l)/(3.14159 * 2 * r);
// How long is a degress along a curve of radius r?
function a2l(a, r) = (2*3.14159*r) * (a/360);

// Makes a pie shape of radius 'r', angle 'a', height 'h'.
// Is just a 2d polygon if no 'h' is specified.
//
// Do not touch 'steps', 'mstep', or 'arr', they set themselves according to
// the values of $fn, $fa, $fs.
//
// Don't use for circles, that's what circle() or cylinder() are for.
module pie(a=90, r=2, h=0, steps=0, mstep=0, arr=[]) {
	// For less mess I should separate this into two calls, one which sets
	// up everything recursive.  For now it just checks for an empty array
	// before doing setup.

	if(len(arr) == 0)
	{
//		echo("special first case");
		if($fn > 0)
		{
			pie(a, r, h, $fn, $fn, [ [0,0] ]);
			/* fragments by $fa:  a / $fa					*/
			/* fragments by $fs:  (a * 2 * pi * r)/(360*$fs) */
		} else assign(frag=ceil(min(a/$fa,(a*2*3.14159*r)/(360*$fs))))
			pie(a, r, h, frag, frag, [ [0,0] ]);

		//	The old way, using $fa alone
		//	pie(a, ceil(a/$fa), ceil(a/$fa), [ [0,0] ], r);
	}
	else if(steps >= 0)
	{
		assign(angle = a-((a/mstep) * steps))
			pie(a, r, h, steps-1, mstep, concat(arr, [ r*[sin(angle),cos(angle)]]));
	}
	else {
		if(h != 0) linear_extrude(h) polygon(arr);
		else						polygon(arr);
	}
}

module curved_arrow(r=20, w=2, length=20, arrow=2, a1=[], step, mstep=0,
	a=0, h=0, center=false) {
	if(mstep == 0) {
		// echo("special first case");
		if(a != 0)
			curved_arrow(r, w, a2l(r, a), arrow, [], 0, ceil(a / $fa),
				h=h, center=center);
		else if(length != 0)
			curved_arrow(r, w, length, arrow, [], 0, ceil(l2a(length,r) / $fa),
				h=h, center=center);
	}
	else if(step <= mstep)
	assign(maxa=l2a(length-(arrow+w),r)) assign(a=(step*maxa)/mstep)
	{
		curved_arrow(r, w, length, arrow,
			concat([	(r-w)*[sin(a),cos(a)] ], a1, [	(r+w)*[sin(a),cos(a)] ]),
			step+1, mstep,h=h, center=center);
	}
	else assign(maxa=l2a(length,r), lasta=l2a(length-(arrow+w),r))
	{
		if(h == 0)
		polygon(concat(a1, [
				(r+w+arrow)*[sin(lasta),cos(lasta)],
				          r*[sin(maxa),cos(maxa)],
				(r-(w+arrow))*[sin(lasta),cos(lasta)]
			]	));
		else linear_extrude(h, center=center) polygon(concat(a1, [
				(r+w+arrow)*[sin(lasta),cos(lasta)],
				          r*[sin(maxa),cos(maxa)],
				(r-(w+arrow))*[sin(lasta),cos(lasta)]
			]	));
	}
}

/*module troch(r1=3, r2=1, m=4, step=0, mstep=64, arr=[])
assign(w1 = 360 * (step/mstep), w2=360*(m)*(step/mstep) ) {
	if(step < mstep) {
		troch(r1, r2, m, step+1, mstep,
			concat(arr, [
					(r1 * [ sin(w1), cos(w1) ]) +
					(r2 * [ sin(w1-w2), cos(w1-w2) ])
				]));
	}
	else
	{
		echo(arr);
		polygon(arr);
	}
}*/


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

rotate([0,0,-(20*360*$t)/5]) difference() {	
	cylinder(r=45, center=true, h=10);
	linear_extrude(11, center=true, convexity=3) rtroch_b(n=5);
}

translate([0,7.5,0]) rotate([0,0,-(20*360*$t)/4]) difference() {
	linear_extrude(10, center=true, convexity=4) rtroch_b(n=4, r1=30-7.5);
	translate([0,0,4]) curved_arrow(r=10, a=359, arrow=2, h=2);
}




//translate([0,0,2]) troch_b();
//						troch_a();
/*difference() {
	pie(r=20, a=270, h=1);
	translate([0,0,.5]) rotate([0,0,-5])
		curved_arrow(r=15, a=260, arrow=1.5, h=1);
}*/
