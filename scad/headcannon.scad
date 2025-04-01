// Filament diameter
fd=1.75; // 0.01

// Hob outer diameter
hod=19.48; // 0.01

// Hob pitch diamete
hd=18.85; // 0.01

// Worm wheel outer diameter
wwod=20.5; // 0.01

// Worm wheel pitch diameter
wwpd=19.5; // 0.5

// Idler bearing diameter
ibd=6; // 0.1

// Idler bearing angle
iba=26; // 0.1

// Idler preload
ipl=0.07; // 0.01

// Worm pitch radius
wr=4.3; // 0.01

// Worm threaded(?) length
wl=10.5; // 0.1

// Depth of filament hob cut into filament
bite=0.15; // 0.01

fr=fd/2;
hor=hod/2;
hr=hd/2-bite; // hob (pitch) radius incorporates bite
br=ibd/2;
wwr=wwpd/2;

// Offset of filament center line to account for idler curvature
//ofs = -0.23;
ofs = -(hr+2*fr+br)*(1-cos(iba/2));

part="assembly"; // [ "assembly", "bottom", "top", "insert", "insert_cover" ]

// bite: orig 0.1, then 0.02, then 0.06
// pp: 0.06
// blue: 0.1
// new pp: 0.17
// 

//br=9/2;
//ba=35;
//ofs=-0.7;

module nut_cuts()
translate([hr+fr+ofs,0,0]) {
	for (a=[-iba/2,iba/2])
	rotate([0,a,0])
	translate([-hr-2*fr-br+ipl,4,0])
	rotate([-90,0,0]) {
		linear_extrude(height=10)
		rotate(-a)
		hexagon(5.5);
	}
}

module bearing_holders()
translate([hr+fr+ofs,0,0]) {
	// hob & worm wheel bearing
	wwbc = 0.05;
	rotate([90,0,0]) {
		translate([0,0,-1.5-3.5])
		cylinder(d=3,h=9+7);

		translate([0,0,-1.5-3.5-wwbc]) {
			translate([0,0,3.5/2])
			cylinder(d=9+2*wwbc,h=3.5/2);
			cylinder(d=8+2*wwbc,h=3.5);
		}
		translate([0,0,1.5+6+wwbc]) {
			cylinder(d=9+2*wwbc,h=3.5/2);
			cylinder(d=8+2*wwbc,h=3.5);
		}
	}

	// worm bearings
	wbc = 0.12;
	translate([14.05,-3/2-1-5/2,-wl/2-4]) {
		cylinder(d=10+2*wbc,h=4);
		translate([0,0,1.2])
		cylinder(d=11+2*wbc,h=2.8);
		translate([0,0,wl+4+5])
		cylinder(d=11+2*wbc,h=2.8);
		translate([0,0,wl+4+5])
		cylinder(d=10+2*wbc,h=4);

		translate([0,0,-4])
		cylinder(d=7.5,h=34);

		translate([0,10/2,0])
		cylinder(d=0.8,h=wl+4+5+4);
	}
	
	for (a=[-iba/2,iba/2])
	rotate([0,a,0])
	translate([-hr-2*fr-br+ipl,0,0])
	rotate([90,0,0]) {
		cylinder(d=3,h=100,center=true);
	}
}

module gear_cuts()
translate([hr+fr+ofs,0,0]) {
	rotate([90,0,0]) {
		cylinder(r=hor+0.5,h=3+0.5,center=true);
		translate([0,0,1.5])
		cylinder(d=wwod+1,h=6+0.5);
	}
}

module idler_cuts(tops=true)
translate([hr+fr+ofs,0,0]) {
	for (a=[-iba/2,iba/2])
	rotate([0,a,0])
	translate([-hr-2*fr-br+ipl,0,0])
	rotate([90,0,0]) {
		translate([0,0,-1-0.4])
		difference() {
			hull() for (x=[0,-0.5])
			translate([x,0,0])
			cylinder(r=br+0.3,h=2.0+0.7);
			cylinder(d1=5.5,d2=4.5,h=1,center=true);
		}
		translate([0,0,0.3/2])
		cylinder(r=br+0.3,h=2.0+0.3,center=true);
		if (tops)
		translate([0,0,(2.0+0.6)/2])
		cylinder(r1=br+0.3,r2=0,h=1*(br+0.5));
	}
	// old fix for tiny unprintable wall?
	*translate([-hr-2*fr-br+ipl,0,0])
	rotate([90,0,0])
	translate([0,0,-1-0.4])
	cylinder(r=0.8,h=2.0+0.7);
}

module filament_cuts() {
	intersection() {
		translate([hr+fr-ipl+ofs,0,0])
		rotate([90,0,0])
		rotate_extrude(convexity=3)
		translate([hr+fr,0])
		circle(d=2.1);

		translate([-hr,0,0])
		cube([2*hr,4*fr,2*hr],center=true);
	}

	cylinder(d=2.1,h=4*hr,center=true);
}



module base_profile(top=false)
offset(r=1) offset(r=-2) offset(r=1)
union()
{
	if (!top)
	rotate(sa-90)
	square([18,10],center=true);

	hull() {
		if (!top)
		rotate(sa-90)
		translate([0,10/2])
		square([18,1],center=true);
		else
		circle(d=10);

		translate([hr+fr+ofs-11/2+5/2,-3])
		square([5,19],center=true);
	}
	
	translate([hr+fr+ofs,-3])
	square([11,19],center=true);

	translate([hr+fr+ofs,0])
	for (p=[[3,-19/2-3-.3],[-3,19/2-3+.3]])
	translate(p)
	if (top)
	circle(d=5);
	else
	rotate(sa)
	hexagon(7);

	hull() {
		translate([hr+fr+ofs+5.5+3/2,-3])
		square([3,19],center=true);
		translate([hr+fr+ofs+wwr+wr,-3/2-1-5/2])
		circle(d=15);
		translate([hr+fr+ofs+wwr+wr,-3/2-1-5/2])
		for (a=[12,192]) rotate(a)
		translate([0,16/2])
		if (top) circle(d=5);
		else rotate(sa) hexagon(7);
	}
}


module housing_base() {
	translate([-3,-3,-wl/2-6])
	cube([5,6,wl+9+2]);

	translate([0,0,-wl/2-6])
	linear_extrude(height=3.6,convexity=3)
	base_profile();

	translate([0,0,wl/2+6+5-3.6])
	linear_extrude(height=3.6,convexity=3)
	base_profile(top=true);

	// worm holder sides
	translate([0,0,-wl/2-6])
	linear_extrude(height=wl+12+2,convexity=3) {
		translate([hr+fr+ofs+wwr+wr,-3/2-1-5/2])
		difference() {
		union()
		for (a=[12,192]) rotate(a)
		//for (a=[150,330]) rotate(a)
		translate([0,16/2])
		circle(d=5);
		circle(d=12);
		}
	}

	// wheel holder sides
	translate([0,0,-wl/2-6+3])
	linear_extrude(height=wl+9+2,convexity=3)
	offset(r=1) offset(r=-1)
	union()
	{
		translate([hr+fr+ofs,0]) {
			translate([-5.5,2.5])
			square([11,4]);
			translate([-5.5,-2.5-4-6])
			square([11,4]);

			translate([3,-19/2-3-0.3])
			circle(d=5);
			translate([-3,19/2-3+0.3])
			circle(d=5);
		}
	}

	// worm mockup
	*%translate([hr+fr+ofs+wwr+wr,-3/2-1-5/2,0])
	cylinder(d=8,h=wl,center=true);

	// top worm holder
	translate([hr+fr+ofs+wwr+wr,-3/2-1-5/2,wl/2+6+2])
	mirror([0,0,1])
	cylinder(d1=15,d2=13.5,h=1.5);

	//bottom worm holder
	translate([hr+fr+ofs+wwr+wr,-3/2-1-5/2,-wl/2-6+3])
	cylinder(d1=15,d2=13.5,h=1.5);

	// rev bowden holder
	translate([0,0,wl/2+6+2+3-10+1])
	difference() {
		translate([0,0,1])
		cylinder(d=10,h=5);
		*rotate([0,-45,0])
		translate([0,0,-20/2])
		cube(20,center=true);
	}
	// filament path holder v2
	//translate([0,0,wl/2+6+5-3.6])
	translate([0,0,wl/2+6+5-9])
	linear_extrude(height=5.4,convexity=3)
	intersection() {
		base_profile(top=true);
		translate([-50+6,0]) square(100,center=true);
	}
}

module mount_holes() {
	rotate(sa)
	for (y=[-6,6]) translate([0,y,-wl/2-6+1.6]) {
		cylinder(d=2.8,h=10,center=true);
		cylinder(d=5.0,h=10);
	}
}

module bottom_nut_holes() {
	translate([0,0,-wl/2-6-1])
	linear_extrude(height=3.4,convexity=3) {
		translate([hr+fr+ofs+wwr+wr,-3/2-1-5/2])
		for (a=[12,192]) rotate(a)
		//for (a=[150,330]) rotate(a)
		translate([0,16/2])
		rotate(sa)
		hexagon(5.1);

		translate([hr+fr+ofs,0]) {
			translate([3,-19/2-3-.3])
			rotate(sa) hexagon(5.1);
			translate([-3,19/2-3+.3])
			rotate(sa) hexagon(5.1);
		}
	}

	//top
	translate([0,0,wl/2+6+5-2.2])
	linear_extrude(height=3,convexity=3) {
		translate([hr+fr+ofs+wwr+wr,-3/2-1-5/2])
		for (a=[12,192]) rotate(a)
		//for (a=[150,330]) rotate(a)
		translate([0,16/2])
		rotate(-15)
		hull() for (i=[0,5]) translate([0,i])
		circle(d=5.2);

		translate([hr+fr+ofs,0]) {
			translate([3,-19/2-3-.3])
			circle(d=5.2);
			translate([-3,19/2-3+.3])
			circle(d=5.2);
		}
	}


	translate([hr+fr+ofs,0,0]) {
		translate([3,-19/2-3-.3])
		cylinder(d=2.8,h=100,center=true);
		translate([-3,19/2-3+.3])
		cylinder(d=2.8,h=100,center=true);
	}

	translate([hr+fr+ofs+wwr+wr,-3/2-1-5/2])
	for (a=[12,192]) rotate(a)
	translate([0,16/2])
	cylinder(d=2.8,h=100,center=true);
}

module rev_bowden_hole() {
	translate([0,0,wl/2+6+2+3]) {
		translate([0,0,-3/4])
		cylinder(d1=2,d2=6,h=2,center=true);
		translate([0,0,-8])
		cylinder(d=4.2,h=9);
		//translate([0,0,h-0.5])
	}
}

module filament_path_slot() {
	translate([-3,-3,-wl/2-6-1])
	translate([-0.05,-0.05,0])
	cube([5.1,6.1,wl+11]);
}

module skylight_hole() {
	translate([hr+fr+ofs+1,-3,wl/2+6+2])
	cube([wwod/2+2,9,10],center=true);
}

module housing()
difference() {
	housing_base();
	bearing_holders();
	gear_cuts();
	filament_cuts();
	nut_cuts();
	mount_holes();
	bottom_nut_holes();
	rev_bowden_hole();
	filament_path_slot();
	skylight_hole();
}

module housing_bottom()
intersection()
{
	housing();
	translate([0,0,-200/2])
	cube(200,center=true);
}

module housing_top()
difference()
{
	housing();
	translate([0,0,-200/2])
	cube(200,center=true);
}

if (part == "assembly") {
	housing_bottom();
	housing_top();
	filament_path_insert();
	filament_path_insert_cover();
} else if (part == "bottom") {
	housing_bottom();
} else if (part == "top") {
	rotate([0,180,0])
	housing_top();
} else if (part == "insert") {
	rotate([-90,0,0])
	filament_path_insert();
} else if (part == "insert_cover") {
	*%filament_path_insert();
	rotate([0,-90,0])
	filament_path_insert_cover();
}


//rotate([-90,0,0])


module filament_path_insert_body()
{
	translate([0,0,-wl/2-6-1])
	cylinder(d1=3,d2=4,h=1);

	translate([0,0,-wl/2-6])
	linear_extrude(height=wl+10,convexity=3)
	offset(r=0.4) offset(r=-0.4)
	translate([-0.5,0])
	square([5,6],center=true);

	rotate([-90,0,0])
	linear_extrude(height=3,convexity=3)
	translate([-br-1,0])
	offset(r=3) offset(r=-3)
	square([2*br+2,4*br+2],center=true);
}

module filament_path_insert()
difference() {
	filament_path_insert_body();
	bearing_holders();
	gear_cuts();
	idler_cuts();
	filament_cuts();
	
}

module idler_holder_profile() {
	translate([-br-1,0])
	offset(r=3) offset(r=-3)
	square([2*br+2,4*br+2],center=true);
}

module filament_path_insert_cover_body()
{
	*translate([hr+fr+ofs,0,0]) {
	// old bearing spacers
	for (a=[-iba/2,iba/2])
	rotate([0,a,0])
	translate([-hr-2*fr-br+ipl,0,0])
	rotate([90,0,0]) {
		translate([0,0,1])
		cylinder(d=4.5,h=2);
	}	

	// old top plate
	*hull()
	for (a=[-iba/2,iba/2])
	rotate([0,a,0])
	translate([-hr-2*fr-br+ipl,0,0])
	rotate([90,0,0]) {
		translate([0,0,3])
		cylinder(r=br,h=0.6);
	}
	}

	// main body
	rotate([-90,0,0]) difference() {
		translate([0,0,4])
		mirror([0,0,1])
		linear_extrude(height=9.6,convexity=3)
		translate([-br-1,0])
		//offset(r=3) offset(r=-3)
		hull() {
			translate([-1/2,0])
			square([2*br-1,4*br+3],center=true);
			translate([-1/2,0])
			square([2*br+3,4*br-1],center=true);
		}

		// inlay for main insert
		translate([0,0,-0.1])
		linear_extrude(height=3.15,convexity=3)
		translate([-br-1,0])
		offset(r=3.2) offset(r=-3)
		hull() for (x=[0,10]) translate([x,0])
		square([2*br+2,4*br+2],center=true);

		// screw head holes
		rotate([-90,0,0])
		translate([hr+fr+ofs,0,0])
		for (a=[-iba/2,iba/2])
		rotate([0,a,0])
		translate([-hr-2*fr-br+ipl,0,0])
		rotate([-90,0,0]) {
			translate([0,0,3])
			//cylinder(d=5.6,h=100);
			linear_extrude(height=100,convexity=3)
			rotate(-a)
			hexagon(5.5);
		}	
	}

	*rotate([-90,0,0])
	translate([0,0,-3])
	linear_extrude(height=3,convexity=3)
	translate([-br-1,0])
	offset(r=3) offset(r=-3)
	square([2*br+2,4*br+2],center=true);
}

module filament_path_insert_cover()
difference() {
	filament_path_insert_cover_body();
	*nut_cuts();
	bearing_holders();
	gear_cuts();
	mirror([0,1,0])
	idler_cuts();
	*translate([100/2-3,100/2-3,0])
	cube(100,center=true);
	translate([-1/2,0,0])
	cube([5,6.1,100],center=true);
	translate([-1/2,-5,0])
	cube([5,6.1,100],center=true);

	// get rid of unprintable stub
	translate([-2,0,0])
	rotate([-90,0,0])
	translate([0,0,-1.4])
	cylinder(d=1,h=2+1.4);
}




sa=-15;
//sa=0;



// below are mounting mockups


// heatsink and fan
*%rotate(sa) {
translate([0,0,-25/2-wwod/2-1])
cube([13,25,25],center=true);

translate([13/2+10/2,0,-25/2-wwod/2-1])
cube([10,25,25],center=true);
}



// bearings
*%translate([hr+fr+ofs,0,0]) {
	rotate([90,0,0])
	cylinder(r=hr,h=3,center=true);

	*for (i=[-1,1])
	translate([0,(3-0.5)/2*i,0])
	rotate([90,0,0])
	cylinder(r=hor,h=0.5,center=true);

	for (a=[-iba/2,iba/2])
	rotate([0,a,0])
	translate([-hr-2*fr-br+ipl,0,0])
	rotate([90,0,0])
	cylinder(r=br,h=2.5,center=true);

	*translate([-hr-2*fr-0.3,0,0])
	rotate([90,0,0])
	cylinder(r=1,h=2.5,center=true);
}


// filament
*%cylinder(r=fr,h=2*hr,center=true);


module hexagon(w) polygon([for (i=[1:6]) w/sqrt(3) * [cos(60*i), sin(60*i)]]);




$fs=.2;
$fa=5;
