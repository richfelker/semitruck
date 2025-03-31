
s=12;
bod=6;
bid=3;
bt=2; // 0.5

part="arm"; // [ "arm", "big", "end", "center" ]
preview=false;

module center_block(s=s) {
difference() {
	cube(s,center=true);
	for (ax=[0,90])
	rotate([ax,0,0])
	for (az=[0,90])
	rotate(az)
	for (ay=[0:3])
	rotate([0,45+90*ay,0])
	translate([(s-1.2)*sqrt(2)/2+s,0,0]) cube(2*s,center=true);

	for (a=[0:90:270]) rotate(a) {
	translate([s/2-bt,0,0])
	rotate([0,90,0])
	cylinder(d=6.1,h=10);

	translate([s/2-bt-0.6,0,0])
	rotate([0,90,0])
	cylinder(d1=3.5,d2=5.0,h=1);

	translate([s/2-bt-0.6,0,0])
	hull()
	for (z=[0,s]) translate([0,0,z])
	rotate([0,90,0])
	cylinder(d1=3,d2=3.75,h=1);

	hull() {
		translate([s/2-bt+0.2,0,1.9])
		rotate([0,90,0])
		cylinder(d=6,h=10);

		translate([s/2-bt+0.2,0,s])
		rotate([0,90,0])
		cylinder(d=6.1,h=10);
	}
	}
}
}

module new_arm_outer(s=12,extra=0) {
	intersection() {
		translate([0,-s/2,0])
		hull() {
			for (z=[-3,3],y=[0,s])
			translate([0,y,z])
			scale([1,1,(s+1)/(s+6)])
			sphere(d=s+6);
		}
		rotate([0,90,0])
		linear_extrude(height=4*s,center=true,convexity=3)
		hull() {
			circle(d=6);
			for (a=[-30,30])
			rotate(a)
			translate([0,-2*s])
			circle(d=6);
		}
	}
	rotate([90,0,0])
	linear_extrude(height=12+s/2+(s+6)/2,convexity=3)
	difference() {
	square([s+1+2*extra,s+7],center=true);
	for (i=[-1,1],j=[-1,1])
	translate([(s/2+5+extra)*i,(s/2+3)*j])
	circle(r=9);
	}
}

module pegs(s=12) {
	for (i=[0,1]) mirror([i,0,0])
	difference() {
		union() {
			translate([s/2-2,0,0])
			rotate([0,90,0])
			cylinder(d1=2,d2=3,h=0.5);

			translate([s/2-1.5,0,0])
			rotate([0,90,0])
			cylinder(d=3,h=2);

			translate([s/2+0.3,0,0])
			rotate([0,90,0])
			cylinder(d1=4,d2=5,h=0.7);

			translate([s/2+1,0,0])
			rotate([0,90,0])
			cylinder(d=6,h=2);
		}
		rotate([90,0,0])
		linear_extrude(height=20,center=true)
		polygon([[0,-3],[s/2+0.3,-1.5],[s/2-2,-0.5]]);
	}
}

module new_arm(s=12,end=false,sw=6) {
	difference() {
		new_arm_outer(s=s,extra=(end||sw>6?2:0));
		translate([0,-s/2,0])
		hull() {
			sphere(d=s+2);
			for (a=[-60,60])
			rotate([a,0,0])
			translate([0,2*s,0])
			sphere(d=s+2);
		}
		for (i=[0,1]) mirror([0,0,i])
		translate([0,0,200/2+s/2+2])
		cube(200,center=true);

		translate([0,-s/2-(s+6)/2-1,0])
		if (!end) {
			rotate([90,0,0])
			rotate(45) {
				translate([0,0,100/2])
				cube([sw,sw,100],center=true);
				translate([0,0,100/2+10.4])
				hull() {
					cube([sw,sw,100],center=true);
					cube([sw+2,sw+2,98],center=true);
				}
			}

			for (a=[0:90:270])
			rotate([0,a,0])
			translate([0,-12,-10/2])
			rotate([-35,0,0])
			translate([0,0,-100/2])
			cube(100,center=true);
		} else {
			rotate([90,0,0])
			//cylinder(d=5.05,h=70,center=true);
			linear_extrude(height=70,center=true)
			rotate(180)
			D(5.05);
			//cylinder(d=5.05,h=7);
			translate([0,-6,0])
			translate([0,-100/2,0])
			cube(100,center=true);
			translate([0,0,0])
			translate([0,-100/2,100/2])
			cube([1.8,100,100],center=true);

			translate([0,-2.5,4.6])
			rotate([0,90,0]) {
				cylinder(d=2.9,h=100,center=true);
				translate([0,0,1.8/2+1.2])
				cylinder(d=5.2,h=100);
				mirror([0,0,1])
				translate([0,0,1.8/2+1.2])
				linear_extrude(height=100,convexity=3)
				hexagon(5.1);
			}
		}
	}
	pegs(s);
}

module D(d=5,f=.5) {
	intersection() {
		circle(d=d);
		translate([0,-f]) square([10,d],center=true);
	}
}

module hexagon(w) polygon([for (i=[1:6]) w/sqrt(3) * [cos(60*i), sin(60*i)]]);

if (part=="arm")
new_arm(end=false);
if (part=="big")
new_arm(end=false,sw=10);
else if (part=="end")
new_arm(end=true);
else if (part=="center")
center_block();


if (preview)
%
rotate([55,0,0])
{
rotate([-90,0,0])
center_block();
rotate([0,90,180]) new_arm();
}

$fs=.2;
$fa=5;
