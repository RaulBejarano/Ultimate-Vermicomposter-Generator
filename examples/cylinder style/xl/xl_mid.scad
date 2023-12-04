use <../../../vermicomposter_cylinder.scad>

$fn = 100;

vermicomposter_cylinder(
    d = 210,
    height = 120,
    con = 5,
    bottom = [2, 20],
    column_d = 6,
    columns = 80,
    holes_mt = 25,
    holes_var = 12.5
);