// Semitruck Prime telescopic coupler

part="housing"; // [ "assembly", "housing", "insert", "stabilizer" ]

tighter=0.0; // 0.01
tighter2=0.0; // 0.01

module telescope_insert() {
	//body
	linear_extrude(height=10)
	difference() {
		translate([3,3])
		polygon([[0,0],[9,0],[9,1],[7,3],[3,3],[3,7],[1,9],[0,9]]);

		translate([2,2]) circle(r=3);
	}

	//pegs
	for (z=[5])
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

module telescope_housing() difference() {
	union() {

		// columns
		linear_extrude(height=10,convexity=3)
		for (a=[0:90:270])
		rotate(a)
		translate([6,6,0])
		intersection() {
			square(8);
			hull() for (i=[0,0.5],j=[0,0.5])
			translate([i,j]) circle(r=7.5);
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
				translate([0,0,8])
				linear_extrude(height=7,convexity=3)
				square(28,center=true);

				translate([0,0,15])
				//hull()
				{
					linear_extrude(height=12,scale=0.75,convexity=3)
					difference() {
						square(26,center=true);
						for (a=[0:90:270]) rotate(a)
						translate(14*[1,1]) circle(r=12);
					}
					linear_extrude(height=12,convexity=3)
					square(14,center=true);
				}
			}
			// tilted inner ceiling
			for (a=[0:90:270]) rotate(a)	
			translate([0,12,9.8])
			rotate([90-15,0,0])
			linear_extrude(height=24,convexity=2,center=true)
			polygon([[-6,0],[-6,-10],[6,-10],[6,0],[0,3.6]]);

			// cosmetic/material-saving cuts
			for (a=[0:90:270]) rotate(a)
			translate([11,11,16])
			rotate([0,90,-45])
			cylinder(r=5,h=40,center=true);
		}
	}

	// Corner cutouts
	for (a=[0:90:270]) rotate(a)
	translate([15,15,1])
	cylinder(r=8,h=40);

	// Screw holes/cutouts
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

	// Interface with 10x10 square shaft
	translate([0,0,10])
	linear_extrude(height=100,convexity=3)
	square(10,center=true);

	translate([0,0,27])
	hull() {
		translate([0,0,-1])
		linear_extrude(height=100,convexity=3)
		square(10,center=true);
		translate([0,0,1])
		linear_extrude(height=100,convexity=3)
		square(12,center=true);
	}
}

module telescope_pulley() difference() {
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

module telescope_stabilizer()
difference() {
	linear_extrude(height=9,convexity=3)
	offset(r=1) offset(r=-1)
	square(8.2,center=true);

	translate([0,0,0.6])
	linear_extrude(height=9,convexity=3) union() {
		square(6,center=true);
		for (a=[0:90:270]) rotate(a)
		translate(2.66*[1,1]) circle(r=0.5);
	}

	translate([0,0,8]) hull() {
		linear_extrude(height=9,convexity=3)
		square(6,center=true);
		translate([0,0,3])
		linear_extrude(height=9,convexity=3)
		square(10,center=true);
	}
	cylinder(d=4.2,h=10,center=true);

}

module telescope_assembly() {
	telescope_housing();

	*rotate([0,180,0])
	translate([0,0,4])
	telescope_pulley();

	telescope_insert();

	for (a=[90:90:270]) rotate(a)
	telescope_insert();

	%translate([6/2+9/2,0,5])
	rotate([90,0,0])
	cylinder(d=9,h=5,center=true);

	%cube([6,6,100],center=true);
	translate([0,0,50+0.6]) rotate([0,180,0]) telescope_stabilizer();

	*%translate([0,0,-19+5])
	cylinder(d=18+15,h=40);
}

// output
if (part == "assembly") {
	telescope_assembly();
} else if (part == "housing") {
	telescope_housing();
} else if (part == "insert") {
	rotate([-90,0,0]) rotate(45)
	telescope_insert();
} else if (part == "pulley") {
	telescope_pulley();
} else if (part == "stabilizer") {
	telescope_stabilizer();
}

module hexagon(w) polygon([for (i=[1:6]) w/sqrt(3) * [cos(60*i), sin(60*i)]]);


$fs=.2;
$fa=5;
