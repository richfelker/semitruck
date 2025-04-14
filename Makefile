STL_NAMES = \
	bearing_clip.stl \
	emotor_mount.stl \
	headcannon_bottom.stl \
	headcannon_top.stl \
	headcannon_insert.stl \
	headcannon_insert_cover.stl \
	noncannonical_bottom.stl \
	noncannonical_top.stl \
	noncannonical_insert.stl \
	noncannonical_insert_cover.stl \
	pulley_60T.stl \
	slider_housing.stl \
	slider_insert.stl \
	slider_pulley.stl \
	ujoint_arm.stl \
	ujoint_big.stl \
	ujoint_end.stl \
	ujoint_motorend.stl \
	ujoint_3mmend.stl \
	ujoint_center.stl \
	wormwheel-hgxv1.stl \
	#

STLS = $(STL_NAMES:%=stl/%)

RELEASE_FILES = semitruck.zip

OPENSCAD = openscad --export-format binstl

-include config.mak


all: $(STLS)

release: $(RELEASE_FILES)

clean:
	rm -rf stl $(RELEASE_FILES)

$(STLS): | stl

stl:
	mkdir -p stl

stl/%.stl: scad/%.scad
	$(OPENSCAD) -o $@ $<

stl/headcannon_%.stl: scad/headcannon.scad
	$(OPENSCAD) -Dpart='"$(patsubst stl/headcannon_%.stl,%,$@)"' -o $@ $<

stl/noncannonical_%.stl: scad/noncannonical.scad scad/headcannon.scad
	$(OPENSCAD) -Dpart='"$(patsubst stl/noncannonical_%.stl,%,$@)"' -o $@ $<

stl/slider_%.stl: scad/slider.scad
	$(OPENSCAD) -Dpart='"$(patsubst stl/slider_%.stl,%,$@)"' -o $@ $<

stl/ujoint_%.stl: scad/ujoint.scad
	$(OPENSCAD) -Dpart='"$(patsubst stl/ujoint_%.stl,%,$@)"' -o $@ $<

stl/pulley_%T.stl: scad/pulley.scad
	$(OPENSCAD) -Dnteeth='$(patsubst stl/pulley_%T.stl,%,$@)' -o $@ $<

stl/wormwheel-hgxv%.stl: scad/wormwheel-hgx.scad
	$(OPENSCAD) -Dversion='$(patsubst stl/wormwheel-hgxv%.stl,%,$@)' -o $@ $<

semitruck.zip: $(STLS)
	zip -r $@ README.md scad stl
