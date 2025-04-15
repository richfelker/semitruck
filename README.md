# The Semitruck Extruder

The Semitruck is a *rigid* remote direct drive (RDD) extruder,
utilizing a double Cardan shaft with printed joints, square
carbon-fiber tube engaging with a slider gear assembly, and an
ultra-compact worm-driven, large-diameter filament hob with dual
idlers. This makes it possible to achieve, simultaneously:

- Extremely low moving mass
- High extrusion speed
- High extrusion force
- Rapid high-precision pressure advance adjustments and retractions
- Near-zero backlash

The double Cardan shaft is net constant-velocity (CV), and is not
subject to position-dependent offset of the shaft angle. The latter
property sets it apart from most other RDD configurations, which rely
on large reduction gear ratios along with well chosen motor
positioning to minimize error.

The Semitruck has been operated at up to 90k mm/s² kinematic
accelerations and 60 mm³/s flow. It can achieve pressure advance
smooth times at least as low as 10 ms.


## Project Status

This is an early private beta for testing and feedback.


## Prerequisites

For delta printers: room for mounting at the top center and clearance
equal to Z travel range above the printer. The exact height
constrtaints are explained below. If the printer has a closed top
cutting/drilling a small hole (between 10 and 22 mm) may be needed for
accommodate the shaft.

For fixed-gantry printers with bed moving down in Z: framing out a
mount above the gantry at height roughly 75% of build width/height
above the top of the toolhead.

Others: not recommended. While the Semitruck *can* be used with any
kinematic system, the needed shaft length and framing above the
printer will be disproportinate and probably unacceptable.


## Mounting Expectations

The toolhead side of the extruder has filament path and screw spacing
designed to mount to a Slice Mosquito or Mellow NF Crazy
heatsink/frame. Creating adapter plates for other mountings, or
variants to the extruder housing, should not be hard, but they are not
included with the official Semitruck distribution at this time.

The motor side of the extruder is designed to mount to the top of a
20-series T-slot or V-slot extrusion with M5 screws and T nuts. The
slider gear should be centered directly above the worm gear shaft on
the toolhead side when the toolhead is at the center of the bed.
Off-center installation may work but increases the stress on the
U-joints towards the edges of the bed and tightens the constraints on
the shaft part lengths.


## Bill of Materials

### Motor, pulley, and and mounting assembly

- LDO 42STH48-2804AC motor (1)
- M3 6 mm screws (4)
- 190-220 mm closed loop GT2 belt (1)
- M3 8 mm screw (1)
- M3 20 mm screws (4)
- M3 nut (5)
- M5 10 mm screw (3)
- M5 T nut (3)
- M5 washer (3)
- Printed `emotor_mount.stl` (1)
- Printed `bearing_clip.stl` (1)
- Printed `pulley_60T.stl` (1)

### Slider gear assembly

- 603ZZ (3x9x5 mm) bearings (8)
- 6702ZZ (15x21x4) bearings (2)
- M2.5 4 mm button head screws (4)
- M2.5 nuts (4)
- Printed `slider_housing.stl` (1)
- Printed `slider_pulley.stl` (1)
- Printed `slider_insert.stl` (4)

### Shaft assembly

- Square 6 mm x 6 mm x round 4 mm ID carbon fiber tube (1)
- MR63 (3x6x2 mm) bearings (8)
- M2.5 6 mm screw (1)
- M2.5 nut (1)
- Printed `ujoint_center.stl` (2)
- Printed `ujoint_arm.stl` (3)
- Printed `ujoint_end.stl` (1)

### Noncannonical (effector side) assembly based on HGX hob

(Skip this section if you are building the original version using the
discontinued NF Cannon gear set.)

- HGX extruder parts set (v1 or v2, see below) (1)
- F3-8M (3x8x3.5 mm) thrust bearings (4)
- M2.5 6 mm screws (2)
- M2.5 25 mm screws (3)
- M2.5 nuts (3)
- M3 10 mm button head screws (2)
- M3 nuts (2)
- MR63 (3x6x2 mm) bearings (2)
- Printed `noncannonical_bottom.stl` (1)
- Printed `noncannonical_top.stl` (1)
- Printed `noncannonical_insert.stl` (1)
- Printed `noncannonical_insert_cover.stl` (1)
- Printed `wormwheel-hgxv1.stl` or `wormwheel-hgxv2.stl` (1)

### Headcannon (effector side) assembly based on NF Cannon gears

(Skip this section if you will be using the HGX gears.)

- Mellow NF Cannon parts - set 2, without motor (1)
- F3-8M (3x8x3.5 mm) thrust bearings (2)
- F5-10M (5x10x4 mm) thrust bearings (2)
- M2.5 6 mm screws (2)
- M2.5 25 mm screws (3)
- M2.5 nuts (3)
- M3 10 mm button head screws (2)
- M3 nuts (2)
- MR63 (3x6x2 mm) bearings (2)
- Printed `headcannon_bottom.stl` (1)
- Printed `headcannon_top.stl` (1)
- Printed `headcannon_insert.stl` (1)
- Printed `headcannon_insert_cover.stl` (1)

### Recommended Sources

- HGX v1 gear set:

- HGX v2 gear set:

- Mellow NF Cannon parts: NOT RECOMMENDED. These are discontinued, and
  may be changed/incompatible if re-issued.

- Carbon Fiber:
  https://windcatcherrc.com/product/carbon-fiber-sq-outer-with-rnd-inner-tube-6mm-x-6mm-x-4mm-x-1000mm/

- Bearings:
  https://www.avidrc.com/product/8/metric-bearings/


## Printed parts

Pregenerated STL files are included with Semitruck release packages.
To build STLs from the OpenSCAD source files, the supplied `Makefile`
can be used in an environment with GNU `make` and the `openscad`
command line interface available. The individual `.scad` files can
also be processed manually in OpenSCAD, using the customizer UI to
select which subpart to generate then exporting the STL.

### Printed worm wheel

If building the Noncannonical (HGX) version with printed worm wheel,
the worm wheel should be printed with 0.14 mm layer height, 100%
infill, and random seams. A seam that is aligned across layers *may
lead to periodic artifacts* and should not be used. Printing this
requires a well-tuned printer and may require some iteration with
different settings depending on material shrinkage and other factors.
The provided source and STL are designed to real physical dimensions,
not any fudge factors for printing with a particular material.

The recommended material for the worm wheel is PET (not PETG). As the
worm wheel and thrust bearings against it need lubrication, it should
not be printed in materials incompatible with grease, such as ABS or
ASA. POM or nylon may be options if PET is not available, but they
have not been tested.

### Other printed parts

The toolhead-side insert parts should be printed with 0.1 mm layer
height and 100% infill for best results. Everything else can be
printed with 0.2 mm layer height, 1.0-1.2 mm shell thickness, and 20%
infill.

Primary development and testing was done with parts printed in PET.

The toolhead-side parts should ideally be printed in material with low
to no creep, and the filament path insert especially should avoid PLA
or other materials that soften at low temperatures, as it's possible
to pull heat up into it when retracting, especially if using long
retractions at end-of-print or when pausing to avoid oozing while
idle.

For the rest of the parts, any rigid material is probably okay, even
PLA.


## Shaft length calculations

In order for the extruder to reach the entire build volume, the
lengths of the middle and vertical shaft segments must be chosen
correctly.

First, work out the middle segment length. A good starting point is
not to go over 45° at the U-joints. To satisfy this on a delta, the
middle segment length should be at least √2 times the build radius. To
satisfy this on a square build area, the middle segment length should
be equal to one side of the square.

Next, determine the height the slider gear and motor should be mounted
at. The vertical distance between the bottom of the slider and the top
of the extruder housing on the toolhead (at max Z) must be at least 45
mm plus the length of the middle shaft segment.

Finally, the end shaft segment length may be worked out based on
toolhead at minimum Z and maximal distance from the origin, but it is
recommended **not** to compute it yet, instead waiting to cut the
shaft until after installation is checked.


## Cutting and assembling the shaft part

The middle shaft segment should be cut to exactly 32 mm shorter than
the length determined above. Each U-joint arm end adds 16 mm to the
length (measured between joint centers).

One U-joint arm end, both in the same orientation, should be pressed
onto each end of the middle shaft segment. They can be attached
permanently with epoxy if desired, but are designed such that press
fit should be sufficient.

Press a single U-joint arm end onto the end shaft segment (not yet cut
to length) and prepare the 5 mm shaft-clamp U-joint end that will
attach to the toolhead side of the extruder by installing the M2.5
hardware on it.

Place a pair of MR63 bearings onto the pegs of one arm end, then slide
them as a unit onto a U-joint center block until they snap into place.
Then, rotate the center block and repeat with the other side of the
joint. A screwdriver shaft can be inserted through the opening between
the arms to hold the center block if pressing the second side of the
joint on is popping the first side's bearings out of their snap-fit
slots.

Repeat for the second U-joint.


## Assembling the slider

The slider consists of a 4-part printed insert holding 8 bearings, an
outer housing, and a printed GT2-tooth-profile pulley integrated with
the cover for the housing.

Assemble half of the insert by pressing four 603ZZ bearings onto the
pegs of one insert piece, then pressing a second insert piece's pegs
into two of the bearings already on the first.

Repeat to assemble the second half of the insert, then press the two
halves together.

Press the insert into the housing.

Press four M2.5 nuts into the hexagonal insets on the cover
(integrated with the pulley), and attach it to the housing using the
four M2.5 4 mm button head screws.

Place the two 6702ZZ bearings over the two ends of the slider assembly
in preparation for slotting it into the motor mount assembly.


## Mounting the extruder motor

Attach the slider to the printed motor bracket with the closed loop
timing belt wrapped around it by pressing the two 6702ZZ bearings into
the slots. The belt should be captured. Press 4 M3 nuts into the slots
beside the bearings, and use the printed bearing clips, each with two
20 mm M3 screws, to secure the bearings.

(Note: The upper clip is optional, since belt tension will suffice to
secure the upper bearing. You may wish to omit it for ease of
disassembly.)

Loosely attach the motor with the 6 mm M3 screws, making sure it can
still slide freely for adjustment. Attach the printed 60T primary
pulley to the motor shaft using an M3 nut and 8 mm M3 screw to secure
the pinch coupler. Bring the timing belt around the pulley, pull the
motor until the belt is no longer slack, and verify vertical alignment
of the belt. If needed, loosen the clamp on the pulley and slide it
up/down on the motor shaft to align with the slider-side pulley, then
retighten. Pull the motor tight to tension the belt adequately, and,
while holding it, tighten down the four motor screws.


## Installing the square shaft

Move the toolhead out of the way well below maximum Z, and insert the
end shaft segment up through the bottom of the slider. The fit should
be somewhat tight, turning the bearings inside the slider as it's
moved. Raise the shaft until the joint at the lower end is higher than
the top of the toolhead, then bring it down onto the worm gear shaft
and clamp it in place by tightening the screw.


## Firmware Configuration

### Noncannonical (HGX based) configuration

The HGX hob has a measured pitch circumference of 56.94 mm, and the
worm gear reduction ratio is 36:2 (18:1). The motor-side pulley
gives a 24:60 (2:5) increase in speed. If using Klipper, these values
can be entered directly without having to do any math:

    [extruder]
    rotation_distance: 56.94
    gear_ratio: 24:60, 36:2

To convert to E-steps-per-mm for other firmware, some math is needed.
Applying the gear ratios, this is 7.90833 mm of filament advance per
rotation of the E motor, or 25.2898 **full steps** per mm. At 16
microsteps per step, that comes to 404.636 E-steps-per-mm.

### Headcannon (NF Cannon gearset based) configuration

The Cannon hob has a pitch circumference documented by Mellow as 59.08
mm, and the worm gear reduction ratio is 39:2 (19.5:1). The motor-side
pulley gives a 24:60 (2:5) increase in speed. If using Klipper, these
values can be entered directly without having to do any math:

    [extruder]
    rotation_distance: 59.08
    gear_ratio: 24:60, 39:2

To convert to E-steps-per-mm for other firmware, some math is needed.
Applying the gear ratios, this is 7.57435 mm of filament advance per
rotation of the E motor, or 26.4049 **full steps** per mm. At 16
microsteps per step, that comes to 422.478 E-steps-per-mm.

### In general

Polarity of the E motor step direction pin will vary depending on
motor wiring. It may be determined experimentally, or set directly to
whichever polarity is known to make the motor spin clockwise (viewed
from the output side).

Additional recommended starting points for settings with Klipper:

    [extruder]
    max_extrude_only_velocity: 45
    max_extrude_only_accel: 4000
    microsteps: 64
    pressure_advance: 0.036
    pressure_advance_smooth_time: 0.010
    
    [firmware_retraction]
    retract_length: 0.20
    # Speeds set way above limit so M220 won't slow down retracts
    retract_speed: 200
    unretract_speed: 200
    
    [tmc5160 extruder]
    run_current: 2.8
    stealthchop_threshold: 0
    interpolate: false

The above TMC configuration should be adapted to your particular
drivers. If they do not support the full current for the motor, it may
be necessary to run at lower retraction acceleration and/or increase
the pressure advance smooth time window.


## Mechanical Validation & First Runs

Once the Semitruck is mounted and configured, start off with manual
motion tests through your printer's UI to check that the shaft slides
freely up and down the slider and does not bind. Motion at low Z
height (upper shaft extended down as far as possible) is the hardest
case, and should be checked at the edges of the build area starting
with short moves, so that binding can be caught before it breaks
anything.

The usual fault mode, if it does break, is explosion of the U-joints,
which are low enough in mass that they should not pose severe danger,
but the bearings can easily be lost if this happens.

If binding is occurring, it may be necessary to mount the motor higher
and use a longer middle shaft segment, but first check that the slider
gear is not too tight on the shaft. This can occur as a result of
printing defects, and can usually be remedied by scraping/sanding the
inside of the slider housing (or reprinting it with very minor
horizontal offset to compensate) so that the bearings are not squeezed
as tightly against the shaft. It's also possible to run the system
restricted to a smaller build radius until the problem is resolved.

Before actual printing, extrusion rate should also be checked to
ensure that the motor is turning in the right direction and that the
correct amount of filament is being advanced. This can be done though
standard methods -- marking a known length of filament going into the
extruder, commanding extrusion of the same length, and verifying that
the marked spot ends at the point of entry to the extruder.

