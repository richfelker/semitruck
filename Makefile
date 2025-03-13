STL_NAMES = \
	bearing_clip.stl \
	emotor_mount.stl \
	headcannon_bottom.stl \
	headcannon_top.stl \
	headcannon_insert.stl \
	headcannon_insert_cover.stl \
	pulley_60T.stl \
	slider_housing.stl \
	slider_insert.stl \
	slider_pulley.stl \
	ujoint_arm.stl \
	ujoint_end.stl \
	ujoint_center.stl \
	#

STLS = $(STL_NAMES:%=stl/%)

OPENSCAD = openscad --export-format binstl

-include config.mak


all: $(STLS)

clean:
	rm -rf stl

$(STLS): stl

stl:
	mkdir -p stl

stl/%.stl: scad/%.scad
	$(OPENSCAD) -o $@ $<

stl/headcannon_%.stl: scad/headcannon.scad
	$(OPENSCAD) -Dpart='"$(patsubst stl/headcannon_%.stl,%,$@)"' -o $@ $<

stl/slider_%.stl: scad/slider.scad
	$(OPENSCAD) -Dpart='"$(patsubst stl/slider_%.stl,%,$@)"' -o $@ $<

stl/ujoint_%.stl: scad/ujoint.scad
	$(OPENSCAD) -Dpart='"$(patsubst stl/ujoint_%.stl,%,$@)"' -o $@ $<

stl/pulley_%T.stl: scad/pulley.scad
	$(OPENSCAD) -Dnteeth='$(patsubst stl/pulley_%T.stl,%,$@)' -o $@ $<
