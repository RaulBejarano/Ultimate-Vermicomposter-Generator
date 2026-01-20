use <../../../vermicomposter_cylinder.scad>

$fn = 100;

vermicomposter_cylinder(
    d = 210,
    height = 120,
    con = 5,
    bottom = [1.6, 20],
    column_d = 6,
    columns = 80,
    holes_mt = 30,
    holes_var = 20
);