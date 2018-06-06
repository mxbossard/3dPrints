$fn=100;

body_width=30;
body_depth=25;
body_height=10;

bracket_width=5;
bracket_height=1;

tower_width=10;
tower_height=20;
tower_drill_height=10;

drill_radius=2;

module body() {
    cube([body_width + bracket_width, body_depth, bracket_height]);
    translate([0, 0, bracket_height])
        cube([body_width, body_depth, body_height - bracket_height]);
    
    translate([0, body_depth - tower_width, bracket_height + body_height - bracket_height])
        cube([tower_width, tower_width, tower_height]);
}

module tower_hole() {
    translate([tower_width/2, body_depth - tower_width - 5, body_height + drill_radius + 5 - bracket_height])
        rotate([270,0,0]) {
            cylinder(tower_width + 10, r=drill_radius);
            translate([-drill_radius, -tower_drill_height, 0])
                cube([drill_radius*2, tower_drill_height, tower_width + 10]);
            translate([0, -tower_drill_height, 0])
                cylinder(tower_width + 10, r=drill_radius);
        }
}

module body_hole() {
    translate([-5, body_height/2, body_height/2 + bracket_height])
        rotate([0,90,0])
            cylinder(body_width + 10, r=drill_radius);
}

module body_lighter() {
    radius=20;
    translate([radius + tower_width, radius + tower_width, bracket_height * 2])
        cylinder(body_height + 10, r=radius);
}

difference() {
    body();
    union() {
        tower_hole();
        body_hole();
        body_lighter();
    }
}
