mount_width = 28;
mount_height = 20;
base_mount_depth = 5;
metal_width = 9.9;

module half_cylinder(height, radius) {
    difference() {
        cylinder(height, radius, radius);
        translate([-radius, 0.5, -0.5]) cube([radius*2, radius, height+1]);
    }
}

module screw_holes(radius = 1) {
    translate([5.6,2.5,10]) rotate([90,0,0]) cylinder(10, radius, radius, center = true);
    translate([mount_width - 5.6,2.5,10]) rotate([90,0,0]) cylinder(10, radius, radius, center = true);
}

module base_mount() {
    difference() {
        cube([mount_width,base_mount_depth,mount_height]);
        
    }
}

module headphone_mount_l() {
    difference() {
        base_mount();
        translate([3,-1,3.5]) cube([mount_width - 6, base_mount_depth - 2, mount_height - 3]);
        translate([0,1,0]) screw_holes();
        translate([(mount_width/2) + 4, 0, -0.5]) cylinder(5,2,2); 
    }
}

module headphone_mount_r() {
    heat_set_insert_radius = 3.5/2;
    
    difference() {
        mirror([0,1,0]) base_mount();
        
        translate([0,-4,0]) screw_holes(heat_set_insert_radius);
        translate([(mount_width / 2) - (metal_width / 2),-0.9,6]) cube([metal_width,1,30]);
        translate([(mount_width / 2),-2.5,11]) rotate([90,0,0]) cylinder(3.5, heat_set_insert_radius, heat_set_insert_radius, center = true);
        translate([(mount_width / 2),-2.5,11+6]) rotate([90,0,0]) cylinder(3.5, heat_set_insert_radius, heat_set_insert_radius, center = true);
    }
    
    attach_depth = 6;
    
    difference() {
        translate([0,-base_mount_depth-attach_depth,0]) cube([mount_width, attach_depth, mount_height*0.66]);
        translate([mount_width / 2, -7, -1]) half_cylinder(30, 2);
    }
}

translate([0,25,base_mount_depth]) rotate([-90,0,0]) headphone_mount_l();
translate([0,mount_height,base_mount_depth + 6]) rotate([90,0,0]) headphone_mount_r();