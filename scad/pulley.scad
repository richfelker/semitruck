gh=7;
nteeth=60;

module hexagon(w) polygon([for (i=[1:6]) w/sqrt(3) * [cos(60*i), sin(60*i)]]);

module D(d=5,f=.5) {
	intersection() {
		circle(d=d);
		translate([0,-f]) square([10,d],center=true);
	}
}

use <gt2.scad>;

module pinch_coupler(h=8) {
	difference() {
		cylinder(d=16,h=h);
		x = 1.8;
		y = 2;
		z = 3.5;

		linear_extrude(height=100,convexity=3,center=true) translate([0,-5]) square([1.6,10],center=true);

		translate([0,-5/2-y,z])
		rotate([0,90,0]) cylinder(d=3.2,h=100,center=true);

		translate([-x-2.25/2,-5/2-y,z])
		rotate([0,-90,0]) linear_extrude(height=100) hexagon(5.5);

		translate([x+2.25/2,-5/2-y,z])
		rotate([0,90,0]) cylinder(d=5.5/cos(30),h=10);
	}
}

module pulley() {
	module shaft_profile() D(5.1);
	difference() {
		union() {
			r=2*nteeth/PI/2+0.6;
			linear_extrude(height=gh+2,center=true,convexity=3)
			gt2_pulley_profile(teeth=nteeth);
			translate([0,0,-gh/2-1]) cylinder(r=r,h=0.6);
			translate([0,0,gh/2+0.4]) cylinder(r1=r-0.4,r2=r,h=0.6);
			translate([0,0,gh/2+1])
			pinch_coupler(h=8);
		}
		if (nteeth*2 > 40*PI) {
			for (a=[0:90:270]) rotate(a)
			translate([31/2,31/2,0])
			cylinder(d=3,h=50,center=true);
		}
		linear_extrude(height=100,convexity=3,center=true) shaft_profile();
		translate([0,0,-gh/2-1])
		linear_extrude(height=3.2,center=true,scale=(5-2)/(5+2)) offset(delta=2) shaft_profile();

		translate([0,0,gh/2+1+8]) mirror([0,0,1])
		linear_extrude(height=3.2,center=true,scale=(5-2)/(5+2)) offset(delta=2) shaft_profile();
	}
}

pulley();

$fs=.2;
$fa=5;
