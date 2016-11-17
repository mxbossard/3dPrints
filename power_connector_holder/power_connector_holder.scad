$fn=50;

// global sizes
ep = 2;
l = 87;
p = 40;
h = 40;
br = 4; // border

// switch sizes
sw_l = 19.5;
sw_h = 13;

// power connector sizes
pc_l1 = 17.5;
pc_l2 = 5.5;
pc_l = pc_l1 + 2 * pc_l2;
pc_h1 = 14.5;
pc_h2 = 5.5;
pc_h = pc_h1 + pc_h2;
pc_dd = 3; // drill diameter
pc_de = 40; // drill entraxe
pc_tl = pc_de + pc_dd; // total larger

module holder() {
    difference() {
        linear_extrude(height=l)
            polygon(points = [[0,0], [0,p], [ep,p], [h,ep], [h,0]]);

        translate([ep, ep, ep])
            linear_extrude(height = sw_l + 2 * br)
                square(size = [p, h], center = false);
        
        translate([ep, ep,  l - pc_tl - 2 * br - ep - pc_dd])
            linear_extrude(height = pc_tl + 2 * br + pc_dd)
                square(size = [p, h], center = false);
    }
}

module switch_hole() {
    translate([(h - sw_h + ep) / 2, p, ep + sw_l + br])
    rotate([90,90,0])
        linear_extrude(height = p * 2)
            square(size = [sw_l, sw_h]);
}

module power_connector_hole() {
    translate([(h - pc_h + ep) / 2, p, l - pc_dd / 2 - br - ep - pc_dd/2])
    rotate([90,90,0])
        linear_extrude(height = p * 2) {
            translate([(pc_de - pc_l)/2, 0, 0]) {
                polygon(points = [[0,0], [pc_l, 0], [pc_l, pc_h1], [pc_l - pc_l2, pc_h], [pc_l2, pc_h], [0, pc_h1]]);
            }
            translate([pc_de, pc_h / 2, 0]) {
                circle(r = 3);
            }
            translate([0, pc_h / 2, 0]) {
                circle(r = 3);
            }
            
        }
}

module fixation_holes() {
    translate([-h/2, p/2, ep + 3 * br])
        rotate([0, 90, 0])
            linear_extrude(height = 2 * h)
                circle(r = 3);
    
    translate([-h/2, p/2, l - ep - 3 * br])
        rotate([0, 90, 0])
            linear_extrude(height = 2 * h)
                circle(r = 3);
}

module full() {
    difference() {
        holder();
        
        switch_hole();
        power_connector_hole();
        fixation_holes();
    }
}

full();
//power_connector_hole();
//fixation_holes();