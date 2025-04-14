use <wormwheel.scad>;

// HGX hob version to couple with
version = 1;

// Worm gear pitch radius
wr = 2.92;

// Worm gear starts
starts = 2;

// Worm gear modulus
modulus = 0.5; // 0.1

// Worm wheel tooth count
nteeth = 36;

worm_profile = [
	[0,1.52/2],
	[1/8,1.52/2],
	[2/8,-1.52/4],
	[6/8,-1.53/4],
	[7/8,1.53/2],
	[1,1.53/2]
];

module hgx_worm_wheel(profile,radius,starts,modulus,teeth,hob_extra=0.1,tb_extra=0.14,thickness=5) {
	difference() {
		worm_wheel(profile=profile,radius=radius,starts=starts,modulus=modulus,teeth=teeth,thickness=thickness);
		translate([0,0,thickness/2-3]) {
			d=7.55+0.15;
			cylinder(d=d,h=10);
			translate([0,0,thickness/2-hob_extra])
			cylinder(d1=d,d2=d+0.75,h=0.55);
			cylinder(d=3.7,h=100,center=true);
		}
		translate([0,0,5/2-hob_extra])
		cylinder(d=modulus*teeth*2,h=2*hob_extra);
		translate([0,0,-5/2+tb_extra]) mirror([0,0,1])
		cylinder(d=modulus*teeth*2,h=2*tb_extra);
	}
	for (a=[0,180]) rotate(a)
	translate([9/2+2.9/2,0,thickness/2-hob_extra]) {
		cylinder(d1=2.95,d2=2.88,h=2);
		translate([0,0,2])
		cylinder(d1=2.88,d2=1.88,h=0.5);
	}
}

hgx_worm_wheel(profile=worm_profile,radius=wr,starts=starts,modulus=modulus,teeth=nteeth);

$fs = $preview ? 0.5 : .2;
$fa = $preview ? 15 : 5;
