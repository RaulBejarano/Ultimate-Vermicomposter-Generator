use <../../../vermicomposter_cylinder.scad>

$fn = 100;

difference(){
    vermicomposter_cylinder(
        d = 216,
        height = 10,
        con = 0,
        bottom = [7, 8],
        column_d = 0,
        columns = 80,
        holes_mt = 0,
        holes_var = 0 
    );
    cylinder(d=216-14-4, h=8);
}