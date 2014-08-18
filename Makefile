#TARGETS=$(shell echo $(wildcard *.scad) | sed "s/scad/stl/")
TARGETS=\
	carriage-bracket.stl \
	fotek-mount.stl \
	jhead-e3d-mount_v2.stl \
	model.stl \
	mount.stl \
	outer_brace_bottom_bracket.stl \
	outer_brace_upper_bracket.stl \
	tool-clip.stl \
	tripod_brace_bottom.stl \
	tripod_brace_top.stl \
	upper_idler_adjuster_axle.stl \
	upper_idler_adjuster_body.stl \
	vert_carriage_for_623_dual_bearing_roller.stl \
	xxl-lcd-mount.stl

all: ${TARGETS}

%.stl: %.scad
	openscad -o $@ $< #2>/dev/null

clean:
	rm -vf *.stl
