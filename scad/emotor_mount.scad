
module emotor_mount() difference() {

	intersection() {
		linear_extrude(height=52,center=true,convexity=3)
		difference() {
			translate([-80,-8-42/2])
			square([80+16,8+42+20]);

			translate([16,0])
			circle(d=17.5);

			hull() for (x=[-80+16.5,-4-16.5])
			translate([x,0])
			circle(d=31-9);

			difference() {
				union() for (i=[0,1]) mirror([0,i])
				hull() for (x=[-80+5.5,-4-5.5])
				translate([x,31/2])
				circle(d=3.3);
				for (i=[1:3]) translate([-80+i/4*(-4+80),0])
				square([0.2,100],center=true);
			}
		}

		union() {
		rotate([90,0,0])
		linear_extrude(height=100,center=true,convexity=3)
		polygon([
			[16,26],[-1,26],[-5,20-11],
			[-80,20-11],[-80,20-11-4],
			[-4,-26],[16,-26]
		]);
		translate([-90,42/2,-52/2])
		cube([90+16,20,52-6-11]);
		}

		rotate([90,0,90])
		linear_extrude(height=200,center=true,convexity=3)
		polygon([
			[-21,20+6],[-21-8,20],
			[-21-8,-20],[-21,-20-6],
			[21+20,-20-6],[21+20,0],
			[21+8,0],[21+8,20],[21,20+6]
		]);
	}

	// bearings cutouts
	translate([16,0,0]) {
		cylinder(d=34.5,h=40,center=true);
		*translate([0,0,-20])
		linear_extrude(height=40,convexity=3)
		rotate(30) hexagon(34);
		translate([0,0,-20+29/2])
		hull() {
			cube([40,20,29],center=true);
			translate([-4,0,0])
			cube([40,20,21],center=true);
		}
		for (i=[0,1]) mirror([0,0,i])
		translate([0,0,20+1])
		cylinder(d=21.1,h=4.1);
		for (i=[0,1],j=[0,1]) mirror([0,0,i]) mirror([0,j,0])
		translate([0,14,20+2+1])
		rotate([0,-90,0]) {
			cylinder(d=3.1,h=100,center=true);
			translate([0,0,15])
			rotate(30)
			linear_extrude(height=100,convexity=3)
			hexagon(5.5);
		}
	}

	// belt cutout
	*translate([-100/2,-46/2,20-10])
	cube([100,46,10]);
	hull() {
		translate([16,0,20-10])
		cylinder(d=32,h=9);
		translate([-42/2-4,0,20-10])
		cylinder(d=60,h=9);
	}

	// motor cutout
	translate([-90,-46/2,-42+20-11-4])
	cube([90-2,46,42]);

	// motor screw cutouts
	for (i=[0,1]) mirror([0,i,0])
	hull() for (x=[-80+5.5,-4-5.5])
	translate([x,31/2,20-11-2])
	cylinder(d=5.8,h=10);

	// chamfers
	let (cs=16/sqrt(2))
	for (p=[
		[16,-42/2-8,-60],
		[16,42/2+8,0],
		[16,42/2+20,-60],
		[-80,-42/2-8,-60],
		[-80,42/2+20,-60],
	])
	translate(p)
	rotate(45)
	translate([0,0,100/2])
	cube([cs,cs,100],center=true);

	// curve over extrusion
	translate([0,42/2+20,0])
	rotate([0,90,0])
	cylinder(r=12,h=200,center=true);

	// extrusion cutout
	translate([0,21+20/2+1,-20/2-52/2+8])
	cube([200,20+2,20],center=true);

	// extrusion mount holes
	for (p=[
		[16-8,42/2+10,0],
		[-80+8,42/2+10,0],
		[(-80+16)/2,42/2+10,0],
	])
	translate(p)
	translate([0,0,-52/2+8])
	{
		cylinder(d=5.5,h=100,center=true);
		translate([0,0,4.4])
		cylinder(d=10.5,h=100);
		*translate([0,0,8.4])
		cylinder(d=12,h=100);
	}

// extrusion
*%translate([0,21+20/2,-20/2-52/2+8])
cube([200,20,20],center=true);

// motor
*%translate([-30,0,-48/2+40/2-11-4])
cube([42,42,48],center=true);
}


if (0) {
difference() {
	translate([20/2-4,0,0])
	cube([20,42,52],center=true);
	translate([16,0,0]) {
		cylinder(d=32,h=40,center=true);
		cylinder(d=17,h=100,center=true);
		for (i=[0,1]) mirror([0,0,i])
		translate([0,0,20+1])
		cylinder(d=21,h=4);
	}
}

translate([-70/2,-11/2+42/2,40/2-9-5/2])
cube([70,11,5],center=true);
}




rotate([0,90,0])
emotor_mount();

use <slider.scad>;
*color("#202080")
translate([0,0,-16])
rotate([0,-90,0])
translate([0,0,-7])
slider_assembly();

module hexagon(w) polygon([for (i=[1:6]) w/sqrt(3) * [cos(60*i), sin(60*i)]]);

$fs=.2;
$fa=5;
