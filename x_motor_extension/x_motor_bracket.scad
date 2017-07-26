$fn=50;

thickness=2;
body_width=70;
body_length=40;

step_length=25;
step_width=80;

holder_width=50;
holder_inside=7;
holder_height=50;
holder_inner_width=18;
holder_inner_height=30;

tab_height=20;
tab_hole_r=15;
tab_drill_border=10;

drill_r=2;




holder_length=holder_inside + 2*thickness;
holder_base_length=holder_length + 10;
    
module body() {
    difference() {
        cube([body_length, body_width, thickness]);
        holder_drills();
    }
    
    tab();
        
    translate([thickness, 0, 0])
        rotate([0, 0, 180])
            backing();
}

module step() {
    translate([0, -step_width, 0])
        cube([step_length, step_width, thickness]);
    
    tab();
    
    translate([0, -thickness, 0])
        backing();
    translate([step_length -thickness, -thickness, 0])
        backing();
}

module holder() {
    difference() {
        translate([body_length - holder_base_length, 0, 0])
            cube([holder_base_length, body_width, thickness]);
        holder_drills();
    }

    translate([0, (body_width - holder_width)/2, 0]) {
        difference() {
            translate([body_length - holder_length, (body_width - holder_width)/2, thickness])
                cube([holder_length, holder_width, holder_height]);
            
            translate([body_length - holder_length - 1, -1, thickness])
                cube([holder_inside +  thickness + 1, body_width + 2, holder_height + 1]);
        }
        
        translate([body_length - holder_length, (body_width - holder_inner_width)/2, thickness])
            cube([thickness, holder_inner_width, holder_inner_height]);
    }
    
}

module holder_drills() {
    translate([body_length - holder_base_length + 5, body_width/4, -1]) {
        cylinder(thickness+2, r=drill_r);
        
        translate([0, body_width/2, 0])
            cylinder(thickness+2, r=drill_r);
    }
}

module tab() {
    difference() {
        translate([0, -thickness, -tab_height]) {
            difference() {
                cube([step_length, thickness, tab_height + thickness]);
                rotate([-90, 0, 0]) {
                    translate([step_length, 0, -1]) {
                        cylinder(thickness + 2, r=tab_hole_r);
                            
                    }
                }
            }
        }
        translate([thickness, 0, 0]) {
            tab_drill(tab_hole_r + 2, drill_r, tab_drill_border);
        }
    }
}

module tab_drill(radius, width, foo) {
    translate([radius + width, 1, -radius -width]) {
        rotate([90, 0, 0]) {
            intersection() {
                difference() {
                    cylinder(thickness + 2, r=radius + width);
                    translate([0, 0, -1]) {cylinder(thickness + 4, r=radius);};
                }
                linear_extrude(height = thickness + 2) {
                    polygon(points=[[0,0], [-radius -width -10, foo], [-foo, radius + width + 10]]);
                }
            }
        }
    }
}

module backing() {
    backing_width=tab_height - tab_hole_r;
    rotate([-90, 0, -90])
        linear_extrude(height = thickness)
            polygon(points=[[0,0], [backing_width, 0], [0, backing_width]]);
}

body();
//step();
//holder();

