


rotate([90,0,0])
difference() {
	linear_extrude(height=6,center=true,convexity=3) difference() {
		union() {
			circle(d=27);
			offset(r=2) offset(r=-2)
			square([36,6.4],center=true);
		}
		circle(d=17.5);
		translate([0,-50/2]) square(50,center=true);
	}
	cylinder(d=21.1,h=4.1,center=true);
	for (i=[-1,1])
	translate([14*i,0,0]) rotate([-90,0,0]) {
		translate([0,0,3])
		cylinder(d=5.6,h=100);
		cylinder(d=3.15,h=100,center=true);
	}
}



$fs=.2;
$fa=5;
