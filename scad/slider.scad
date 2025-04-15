// Semitruck slider gear

part="assembly"; // [ "assembly", "housing", "insert", "pulley" ]

tighter=0.1; // 0.01
tighter2=0.1; // 0.01
nteeth=24;

module slider_insert() {
	//body
	linear_extrude(height=20)
	difference() {
		translate([3,3])
		polygon([[0,0],[9,0],[9,1],[7,3],[3,3],[3,7],[1,9],[0,9]]);

		translate([2,2]) circle(r=3);
	}

	//pegs
	for (z=[5,15])
	for (i=[0,1]) mirror([i,-i,0])
	translate([6/2+9/2-tighter,3,z])
	rotate([90,0,0]) {
		cylinder(d1=4.5,d2=4,h=0.3);
		translate([0,0,0.3]) {
			cylinder(d=3+tighter2,h=2.4);
			translate([0,0,2.4])
			cylinder(d1=3+tighter2,d2=2.7+tighter2,h=0.2);
		}
	}
}

module slider_housing() difference() {
	union() {

		// columns
		linear_extrude(height=25-5,convexity=3)
		for (a=[0:90:270])
		rotate(a)
		translate([6,6,0])
		intersection() {
			square(8);
			hull() for (i=[0,0.5],j=[0,0.5])
			translate([i,j]) circle(r=7.5);
			//cylinder(r=8,h=100);
			//cube([8,8,27]);
		}

		// bottom frame
		linear_extrude(height=4,convexity=3)
		difference() {
			union() {
				square([28,12],center=true);
				square([12,28],center=true);
			}
			square(24,center=true);
		}

		// top assembly
		difference() {
			union() {
				// top
				translate([0,0,18])
				linear_extrude(height=7,convexity=3)
				square(28,center=true);

				// bearing spacer
				translate([0,0,25])
				cylinder(d=16.2,h=2);

				// bearing insert cylinder
				translate([0,0,26]) {
					cylinder(d=15,h=4);
					translate([0,0,4])
					cylinder(d1=15,d2=14,h=1);
				}
			}
			// tilted inner ceiling
			for (a=[0:90:270]) rotate(a)	
			translate([0,12,19.8])
			rotate([90-15,0,0])
			linear_extrude(height=24,convexity=2,center=true)
			polygon([[-6,0],[-6,-10],[6,-10],[6,0],[0,3.6]]);

			// cosmetic/material-saving cuts
			for (a=[0:90:270]) rotate(a)
			translate([11,11,26])
			rotate([0,90,-45])
			cylinder(r=5,h=40,center=true);

			// roof hole for shaft
			translate([0,0,23.2])
			hull() {
			translate([0,0,-1-4])
			linear_extrude(height=1,convexity=3)
			square(12,center=true);
			linear_extrude(height=4,convexity=3)
			square(8,center=true);
			}
			translate([0,0,23.2])
			linear_extrude(height=20,convexity=3)
			square(8,center=true);
		}
	}

	for (a=[0:90:270]) rotate(a)
	translate([15,15,1])
	cylinder(r=8,h=40);

	for (a=[0:90:270]) rotate(a)
	rotate(45)
	translate([14,0,0]) {
		cylinder(d=2.5,h=3,center=true);
		translate([0,0,1]) hull() {
			cylinder(d1=5.4,d2=4.8,h=6);
			translate([0,0,6])
			cylinder(d1=4.8,d2=0,h=15);
		}
	}

	translate([0,0,28])
	cylinder(d1=8,d2=12,h=3.1);
}

use <gt2.scad>;

module slider_pulley() difference() {
	gh = 7;
	union() {
		translate([0,0,gh/2+1]) {
			r = 2*nteeth/PI/2+1-0.6;
			linear_extrude(height=gh+1,center=true,convexity=3)
			gt2_pulley_profile(teeth=nteeth);
			translate([0,0,-gh/2-1]) cylinder(r=r,h=0.6);
			translate([0,0,gh/2+0.4]) cylinder(r1=r-0.4,r2=r,h=0.4);
			translate([0,0,gh/2+0.8]) cylinder(r1=r,d2=16.2,h=0.2);
		}

		translate([0,0,-4])
		linear_extrude(height=2.2,convexity=3)
		offset(r=7.5-0.5) offset(r=-7.5)
		square(28,center=true);
		translate([0,0,-1.8])
		cylinder(d1=26,d2=18,h=1.8);

		translate([0,0,gh+2])
		cylinder(d=16.2,h=2);
		translate([0,0,gh+3]) {
			cylinder(d=15,h=4);
			translate([0,0,4])
			cylinder(d1=15,d2=14,h=1);
		}
	}
	cylinder(d=9,h=50,center=true);
	translate([0,0,-4])
	cylinder(d1=16,d2=9,h=9,center=true);
	translate([0,0,gh+8])
	cylinder(d2=18,d1=6,h=9,center=true);

	for (a=[0:90:270]) rotate(a)
	rotate(45)
	translate([14,0,-3]) {
		linear_extrude(height=10,convexity=2)
		rotate(30)
		hexagon(5);
		cylinder(d=2.9,h=100,center=true);
	}
}

module slider_assembly() {
	slider_housing();

	rotate([0,180,0])
	translate([0,0,4])
	slider_pulley();

	slider_insert();

	for (a=[90:90:270]) rotate(a)
	slider_insert();

	*%translate([6/2+9/2,0,5])
	rotate([90,0,0])
	cylinder(d=9,h=5,center=true);

	*%cube([6,6,100],center=true);

	*%translate([0,0,-19+5])
	cylinder(d=18+15,h=40);
}

use <emotor_mount.scad>;

// output
if (part == "assembly") {
	*translate([-15,0,-6]) emotor_mount();
	rotate([180,0,0]) slider_assembly();
} else if (part == "housing") {
	slider_housing();
} else if (part == "insert") {
	rotate([-90,0,0]) rotate(45)
	slider_insert();
} else if (part == "pulley") {
	slider_pulley();
}

module hexagon(w) polygon([for (i=[1:6]) w/sqrt(3) * [cos(60*i), sin(60*i)]]);


$fs=.2;
$fa=5;
