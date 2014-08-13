// J-Head (E3D) mount
// https://www.thingiverse.com/thing:148536/
//
// copyright (c) 2013 - Jarek Szczepanski <imrahil@imrahil.com>
// oryginal design derived from http://www.thingiverse.com/thing:26355

length = 25;
height = 9;

mount_spacing = 50;
carriage_mount_dia = 4.5;

// dimensions for E3D hotned //2.9 5.9 7.0
extruder_dia = 16;
extruder_dia2 = 12;
extruder_cyl2_height = 5.9; //5.6 // inner grip height
extruder_cyl1_height = height-extruder_cyl2_height;//5.9; //3.7

mount_screws_dia = 3.5;


// main module
main();

module main() {
  translate([-10, 0, 0]){
    intersection() {
      mount();
      separator();
    }
  }

  difference() {
    mount();
    separator();
  }
}

module mount() {
  difference() {
    plate();
    extruder();
    mount_screws();
  }
}

module plate() {
  difference() {
    union() {
      cube([length, mount_spacing, height],center=true);			// center
      translate([0,mount_spacing/2,0]){
        cylinder(r=length/2, h=height, center=true, $fn=48); 	// round corner
      }

      translate([0, -mount_spacing/2,0]){
        cylinder(r=length/2, h=height, center=true, $fn=32); 	// round corner
      }
    }

    translate([0, -mount_spacing/2,0]){
      cylinder(r=carriage_mount_dia/2, h=height + 1, center=true, $fn=32);	// carriage mount hole
    }

    translate([0, mount_spacing/2,0]){
      cylinder(r=carriage_mount_dia/2, h=height + 1, center=true, $fn=32); // carriage mount hole
    }
  }
}

module extruder() {
  pos1 = height/2 - extruder_cyl1_height/2 + 0.5;
  pos2 = height/2 - extruder_cyl1_height - extruder_cyl2_height/2;

  union() {
    translate([0, 0, pos1]){
      cylinder(r=extruder_dia/2, h=extruder_cyl1_height + 1, center=true, $fn=32); 
    }

    translate([0, 0, pos2]){
      cylinder(r=extruder_dia2/2, h=extruder_cyl2_height, center=true, $fn=32); 
    }	
  }
}

module mount_screws() {
  union() {
    translate([0, 12, 0]){
      rotate([0, 90, 0]) cylinder(r=mount_screws_dia/2, h=length + 1, center=true, $fn=32); // hole for nut
      translate([length/2 - 3, 0, 0]){
        rotate([-90, 0, -90]) cylinder(r=mount_screws_dia, h=4, $fn=6); 
      }
      translate([-length/2 - 0.5, 0, 0]){
        rotate([0, 90, 0]) cylinder(r=3, h=3, $fn=32); // hole for screw's head
      }
    }

    translate([0, -12, 0]){
      rotate([0, 90, 0]) cylinder(r=mount_screws_dia/2, h=length + 1, center=true, $fn=32); // hole for nut 
      translate([length/2 - 3, 0, 0]){
        rotate([-90, 0, -90]) cylinder(r=mount_screws_dia, h=4, $fn=6); 
      }
      translate([-length/2 - 0.5, 0, 0]){
        rotate([0, 90, 0]) cylinder(r=3, h=3, $fn=32); // hole for screw's head 
      }
    }
  }
}

module separator() {
  translate([-20, 0, 0]){
    cylinder(r=43/2, h=height + 1, center=true, $fn=64); 
  }
}
