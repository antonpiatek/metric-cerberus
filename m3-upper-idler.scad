thickness = 2.5;
top_thickness = thickness + 0.5;
height = 23;
width = 20;
gap = 5;
hole_offset = 6.5;
slot_width = 8-0.1;
module side() {
  difference() {
    union() {
      cube([height, thickness, width]);
      translate([0,-0.5,(width-slot_width)/2]) {
        cube([height/2, thickness+0.5, slot_width]);
      }
    }
    translate([hole_offset, -thickness, width/2]) rotate([-90,0,0])
      cylinder(r = 3.2/2, h = thickness*3, $fn = 12);
  }
}

module top() {
  translate([height-top_thickness, 0, 0]) {
    difference() {
      cube([top_thickness, gap+thickness*2, width]);
      translate([-top_thickness, gap/2+thickness, width/2]) rotate([0,90,0])
        cylinder(r = 3.2/2, h = top_thickness*3, $fn = 12);
    }
  }
}

module hex_screw_hole() {
  cylinder(r = 6.4/2, h = 2.4+0.5, $fn = 6);
}

difference() {
  union() {
    side();
    translate([0,gap+thickness*2,0]) mirror([0,-1,0]) side();
    top();
  }
  translate([height-top_thickness,gap/2+thickness,width/2]) {
    rotate([0,-90,0]) {
      hex_screw_hole();
    }
  }
}

%translate([hole_offset, thickness, width/2]) rotate([-90,0,0]) washer(M3_washer) v_ball_bearing(BB623VV) washer(M3_washer);

/* the following definitions are loosely derived from
 * nophead's awesome Mendel90 scad.
 * any bugs are most likely mine.
 */

grey70                          = [0.7, 0.7, 0.7];
grey80                          = [0.8, 0.8, 0.8];
hard_washer_color                = grey80;
bearing_color                    = grey70;

BB624VV = [4, 13, 5, "624VV"];
BB623VV = [3, 12, 4, 1.2, 2.7, "623VV"];

function v_ball_bearing_v_depth(type) = type[3];
function v_ball_bearing_v_width(type) = type[4];

module v_ball_bearing(type) {
    vitamin(str("BB",type[5],": V groove ball bearing ",type[5]," ",type[0], "mm x ", type[1], "mm x ", type[2], "mm, v depth ", type[3], "mm, w width ", type[4]), "mm");

    v_r = type[1]/2-type[3];
    or = type[1]/2;
    ir = type[0]/2;
    h = type[2];
    color(bearing_color) render() difference() {
      rotate_extrude() {
        polygon(points = [ [ir, h],            [or, h],
                                               [or, h/2+type[4]/2],
                                    [v_r, h/2],
                                               [or, h/2-type[4]/2],
                                               [or, 0],
                           [ir, 0]]);
      }
    }
    if($children)
        translate([0, 0, h])
            child();
}

M3_washer  =      [3,   7, 0.5, false,  5.8];
function washer_diameter(type)  = type[1];
function washer_thickness(type) = type[2];
function washer_soft(type)      = type[3];
function washer_color(type) = washer_soft(type) ? soft_washer_color : hard_washer_color;
module washer(type) {
    hole = type[0];
    thickness = washer_thickness(type);
    diameter  = washer_diameter(type);
    if(washer_soft(type))
        vitamin(str("WR", hole * 10, diameter, thickness * 10, ": Rubber washer M", hole, " x ", diameter, "mm x ", thickness, "mm"));
    else
        vitamin(str("WA", hole * 10, diameter, thickness * 10, ": Washer M",        hole, " x ", diameter, "mm x ", thickness, "mm"));
    color(washer_color(type)) render() difference() {
        cylinder(r = diameter / 2, h = thickness - 0.05);
        cylinder(r = hole / 2, h = 2 * thickness + 1, center = true);
    }
    if($children)
        translate([0, 0, thickness])
            child();
}

module vitamin() {}
