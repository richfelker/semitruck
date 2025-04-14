include <headcannon.scad>;

// Filament diameter
fd=1.75; // 0.01

// Hob outer diameter
hod=18.00; // 0.01

// Hob pitch diamete
hd=17.37; // 0.01

// Worm wheel outer diameter
wwod=19.5; // 0.01

// Worm wheel pitch diameter
wwpd=18; // 0.5

// Idler bearing diameter
ibd=6; // 0.1

// Idler bearing angle
iba=28; // 0.1

// Idler preload
ipl=0.07; // 0.01

// Worm outer diameter
wod=7;

// Worm pitch radius
wr=2.92; // 0.01

// Worm mating length
wl=10.5; // 0.1

// Worm sleeve length (extra past functional)
wsl=1.7; // 0.1

// Depth of filament hob cut into filament
bite=0.15; // 0.01

// Angle to center entire extruder
sa=-15; // 0.1

// Worm bolt angles
wba=[-15];

// Worm wheel bolt positions
wwbp=[[3+3,-19/2-3-.3],[-3,19/2-3+.3]];

// Worm thrust bearing OD
wbd=8;

part="assembly"; // [ "assembly", "bottom", "top", "insert", "insert_cover" ]
