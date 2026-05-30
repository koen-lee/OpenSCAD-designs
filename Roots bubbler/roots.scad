include<cycloids.scad>

// this file needs OpenSCAD 2019.5
// because it uses the [ each ...] list comprehension

// lobe major axis is 2(R+2r)
// minor axis is 2(R-2r)
module rootsrotor(lobes,major,stepsize) {
    assert(major%(lobes*2)==0,"Major axis must be an even multiple of lobes");
    sweep = 360/(lobes*2);
    R=major;
    r=major/(lobes*2);
    points = 
         [ each for( i=[0:(lobes*2)-1]) 
             [ for (j=[i*sweep:stepsize:(i+1)*sweep-1])
                 (i%2==0) ? 
                 [hypocycloidX(j,R,r),hypocycloidY(j,R,r)] :
                 [epicycloidX(j,R,r),epicycloidY(j,R,r)]
             ]
         ];
    polygon(points);
};

