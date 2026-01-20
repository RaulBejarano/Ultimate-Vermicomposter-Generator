$fn = 100;

vermicomposter_cylinder(
    d = 210,
    height = 100,
    con = 5,
    bottom = [2, 20],
    column_d = 6,
    columns = 80,
    holes_mt = 25,
    holes_var = 12.5
);

module vermicomposter_cylinder(
    d = 210,
    height = 100,
    con = 5,
    bottom = [2, 20],
    column_d = 6,
    columns = 80,
    holes_mt = 25,
    holes_var = 12.5
){
    angle = 360 / columns;
    wall_margin = 2 * bottom[0];
    
    translate([0,0,con + bottom[1]]) cylinder(h = height - con - bottom[1], d = d); //top
    translate([0,0,bottom[1]]) cylinder(h = con, d1 = d-wall_margin, d2=d); //connector
    cylinder(h = bottom[1], d=d-wall_margin); //bottom

    for(a=[0:columns]){
        n = a%2 ? holes_mt : holes_mt + holes_var;
        
        rotate(a * angle) translate([0,-d/2,bottom[1]+con]) column(
            d = column_d,
            h = height - con - bottom[1],
            hole_mt = n
        );
    }
    
}


module column(
    d = 10,
    h = 40,
    hole_mt = 18
    
){
    scale([1,0.8,1]) difference(){
        union(){
            cylinder(r1=0, r2=d/2, h=d);
            translate([0,0,d]) cylinder(h=h - 2*d, d=d);
            translate([0,0,h-d]) cylinder(r1=d/2, r2=0, h=d);
        }
        if (hole_mt <= h){        
            translate([d/2,0,h-hole_mt]) 
            rotate([0,-90,0]) linear_extrude(d) polygon(points = [
                [0,0],
                [0,-d],
                [sqrt(pow(d,2) - pow(d/2,2)),-d/2]
            ]);
        }
    }
}