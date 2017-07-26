$fn=100;

drill_r=2;

difference() {
    square(220, center=true);

    group() {
        for (a = [0:90:360]) {
            rotate([0, 0, a])
                translate([105, 105])
                    circle(r=drill_r);
        }
        
        rotate([0, 0, 45])
            text("by MaxBundy with Labomedia", halign="center");
    }
}

