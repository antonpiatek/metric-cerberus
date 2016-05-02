// New bed mount as I have a 300mm diameter round (metal) bed which doesn't fit with the 
// existing mounts as it is too big (and one mount is too short anyway)
// EXPERIMENTAL - no idea if this is what I really need yet...
// 


// Import existing mounts as inspiration
%translate([-5,-12,0]) rotate([0,0,20]) import("Cerberus/Glass Bed Mount Bracket.STL");
%translate([10,0,0]) rotate(-38,0,0) import("Cerberus/stl/Glass Bed Mount Bracket.stl");


difference() {
  union(){
    translate([0,-15.5,10]) cube([18,31,20],center=true);
    translate([0,-15.5,22.5]) cube([8,31,5],center=true);
    //corners
    translate([4,-15.5,20]) rotate([90,0,0]) cylinder(r=5, h=31, center=true, $fn=48);
    translate([-4,-15.5,20]) rotate([90,0,0]) cylinder(r=5, h=31, center=true, $fn=48);
    //mount triange
    mountTriangle();
  }
  //stem notches
  translate([8,-23,12]) stemNotch();
  translate([-8,-23,12]) mirror([1,0,0]) stemNotch();
    
  cutout();
  zipTieHole();
}

module zipTieHole(){
 translate([-5,-29,14])  cube([10,12,8]);
}

//mount triangle
module mountTriangle(){
  difference(){
   translate([0,-30,12.5]) scale([0.9,1.4,1]) rotate([0,0,45]) cube([8,8,25],center=true);
   translate([0,-26.5,12.5])  cube([10,8,25],center=true);
   translate([0,-39,12.5])  cube([4,4,25],center=true);
  }
}

//cutout
module cutout(){ //TODO: Rounded edges?
  translate([-10,-38,-1]) cube([20,21,8]);
}

//alternative to cutout, sloping - probably terrible to print...
module slope(){
  translate([-9,-35,3]) rotate([90,95,90]) cube([4,36,18]);
}

module stemNotch(){
  union(){
    translate([-2,2,0]) rotate([0,0,90]) cylinder(r=4, h=28, center=true, $fn=48);
    translate([-2,-2,0]) rotate([0,0,90]) cylinder(r=4, h=28, center=true, $fn=48);
    //these cube rotations are just silly :(
    translate([-3,0,0]) rotate([90,0,0]) cube([6,31,6],center=true);
    translate([-0.5,5,0]) rotate([90,0,0]) cube([4,31,2],center=true);
    translate([-0.5,-5,0]) rotate([90,0,0]) cube([4,31,2],center=true);
    translate([0,-7,0]) cube([3,4,31],center=true);
  }
}


