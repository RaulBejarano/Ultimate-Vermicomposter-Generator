eps = 1/128;

use <../../vermicomposter.scad>

size = [213, 213, 10];
r = 15;
con = 0;
bottom = [7,7,8];
column_d = 0;
column_s = 0;
holes_mt = 0;
holes_var = 0;

thickness = 3;

difference(){
    vermicomposter(size, r, con, bottom, column_d, column_s, holes_mt, holes_var);


    b0 = size[0] - bottom[0] - thickness;
    b1 = size[1] - bottom[1] - thickness;

    translate([0,0,-eps]) linear_extrude(bottom[2]+eps) hull(){
        x = (b0 - 2*r)/2;
        y = (b1 - 2*r)/2;
        translate([-x,-y,0]) circle(r=r);
        translate([-x,y,0]) circle(r=r);
        translate([x,-y,0]) circle(r=r);
        translate([x,y,0]) circle(r=r);

    }
}
