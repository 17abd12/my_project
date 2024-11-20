$fn = 100;
ball_bearing_outer_diameter = 25;
ball_bearing_inner_diameter = 10;
ball_bearing_thickness = 7;
ball_diameter = 3;
number_of_balls = 8;
ball_color = "silver";
outer_ring_color = "gray";
inner_ring_color = "gray";

module ball_bearing() {
    // Outer ring
    color(outer_ring_color)
    difference() {
        cylinder(h = ball_bearing_thickness, r = ball_bearing_outer_diameter / 2);
        cylinder(h = ball_bearing_thickness, r = ball_bearing_inner_diameter / 2);
    }

    // Inner ring
    color(inner_ring_color)
    translate([0, 0, ball_bearing_thickness / 4])
    difference() {
        cylinder(h = ball_bearing_thickness / 2, r = (ball_bearing_outer_diameter / 2) - ball_diameter);
        cylinder(h = ball_bearing_thickness / 2, r = ball_bearing_inner_diameter / 2);
    }

    // Balls
    for (i = [0:number_of_balls-1]) {
        angle = 360 / number_of_balls;
        x = (ball_bearing_outer_diameter / 2 - ball_diameter) * cos(angle * i);
        y = (ball_bearing_outer_diameter / 2 - ball_diameter) * sin(angle * i);
        z = ball_bearing_thickness / 2;
        translate([x, y, z])
        color(ball_color)
        sphere(r = ball_diameter / 2);
    }
}

ball_bearing();