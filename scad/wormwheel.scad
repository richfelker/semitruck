function helix_section(profile,r,starts,n=0) = [
	for (fn=[n>0 ? n : $fn>0 ? $fn :ceil(360/$fa)])
	for (i=[0:fn]) [cos(360*i/fn),sin(360*i/fn)]*(r+lookup((i*starts/fn)%1.0,profile))
];

worm_profile = [
	[0,1.52/2],
	[1/8,1.52/2],
	[2/8,-1.52/4],
	[6/8,-1.53/4],
	[7/8,1.53/2],
	[1,1.53/2]
];

module worm(profile=worm_profile,radius,starts,modulus,length) {
	lead=PI*starts*modulus;
	linear_extrude(height=length,twist=-360*length/lead,convexity=3)
	polygon(helix_section(profile,radius,starts));
}

module worm_wheel(profile=worm_profile,radius,starts,modulus,teeth,thickness)
difference() {
	cylinder(d=modulus*teeth+1.5,h=thickness,center=true);
	for (i=[1:$preview?2:0.5:teeth]) rotate(360*i/teeth)
	translate([modulus*teeth/2+radius,0,0])
	rotate([90,0,0])
	translate([0,0,-2*PI])
	rotate(360/starts * (i%1.0))
	worm(profile=profile,radius=radius,starts=starts,modulus=modulus,length=4*PI);
}

$fs = 0.2;
$fa = 5;
