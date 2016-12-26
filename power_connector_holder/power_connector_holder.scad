$fn=50;

// global sizes
ep = 2;
l = 86; // x
p = 20; // z
h = 40; // y
br = 4; // border

// switch sizes
sw_l = 20;
sw_h = 13;

// power connector sizes
pc_l1 = 17.5;
pc_l2 = 5.5;
pc_l = pc_l1 + 2 * pc_l2;
pc_h1 = 14.5;
pc_h2 = 5.5;
pc_h = pc_h1 + pc_h2;
pc_dd = 4; // drill diameter
pc_de = 40; // drill entraxe
pc_tl = pc_de + pc_dd; // total larger


module holder_profile() {
    translate([p, h, 0])
        rotate([0, 0, 180])
            polygon(points = [[0,0], [0,h], [ep,h], [p,ep], [p,0]]);
}

module switch_profile() {
    square(size = [sw_l, sw_h]);
}

module power_connector_profile() {
    translate([pc_dd/2, 0, 0]) {
        translate([(pc_de - pc_l)/2, 0, 0]) {
            polygon(points = [[0,0], [pc_l, 0], [pc_l, pc_h1], [pc_l - pc_l2, pc_h], [pc_l2, pc_h], [0, pc_h1]]);
        }
        translate([pc_de, pc_h / 2, 0]) {
            circle(r = pc_dd/2);
        }
        translate([0, pc_h / 2, 0]) {
            circle(r = pc_dd/2);
        }
    }
}

module switch_hole() {
    translate([ep + br, (h - sw_h + ep) / 2, 0])
        linear_extrude(height = p + 0.1) {
            switch_profile();
            translate([])
                square(size = [sw_l + 2*br, sw_h + 2*br]);
        }
}

module power_connector_hole() {
    translate([l - pc_tl - ep - br, (h - pc_h + ep) / 2, 0])
        linear_extrude(height = p + 0.1)
            power_connector_profile();
}

module holder() {
    translate([0, 0, p])
        rotate([0, 90, 0])
            linear_extrude(height = l)
                holder_profile();
}

module holder_hollowing() {
    translate([ep, -ep, p + ep])     
        rotate([0, 90, 0])
            linear_extrude(height = sw_l + 2 * br)
                square(size = [p, h], center = false);
        
    translate([l - (pc_tl + 2 * br + ep), -ep, p + ep])
        rotate([0, 90, 0])
            linear_extrude(height = pc_tl + 2 * br)
                square(size = [p, h], center = false);
    
}

module build() {
    difference() {
        holder();
        
        //holder_hollowing();
        switch_hole();
        power_connector_hole();
    }
}
//holder_hollowing();

build();

//switch_profile();
//power_connector_profile();
//holder_profile();



