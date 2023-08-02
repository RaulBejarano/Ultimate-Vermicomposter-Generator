eps=1/128;
$fn=50;

vermicomposter();


module vermicomposter(
    size = [210, 210, 100],
    column_d = 6,
    column_s = 3,  // column separation
    notch = 60,
    notch_var = 7,
    box_radius = 15,
    box_top = 6,
    box_top_r = 13,
    box_bottom = 6,
    box_bottom_r = 10
){
    box(size, box_radius, box_bottom_r, box_top_r, box_top, box_bottom);
    
    columnT = column_d + column_s;
    columnsL = floor((size[0] - 2*box_radius) / columnT);
    offsetL = column_d/2 + (size[0]-(columnsL*(column_d+column_s) - column_s))/2;
    
    column_h = size[2] - box_top - box_bottom;
    z =(size[2] - column_h)/2;
    
    for(a = [0 : columnsL - 1]){
        n = notch + (a%2 ? notch_var : -notch_var);
        x = offsetL + a * columnT;
        
        translate([x,0,z])
            column(column_d, column_h, n);
        translate([x,size[1],z]) 
            rotate(180) column(column_d, column_h, n);
    }
    
    columnsW = floor((size[1] - 2*box_radius) / columnT);
    offsetW = column_d/2 + (size[1]-(columnsW*(column_d+column_s) - column_s))/2;
    for(a = [0 : columnsW - 1]){
        n = notch + (a%2 ? notch_var : -notch_var);
        y =offsetW + a * columnT;
        
        translate([0,y,z]) 
            rotate(-90) column(column_d, column_h, n);
        translate([size[0],y,z]) 
            rotate(90) column(column_d, column_h, n);
    }
    
}

module box(
    size = [200, 100, 50],
    radius = 15,
    bottom_r = 6,
    top_r = 6,
    top = 6,
    bottom = 6
){
    translate([radius,radius,0]){
        hull() 
        for(i = [0 : 1]){
            for(j = [0 : 1]){
                translate([i*(size[0]-2*radius),j*(size[1]-2*radius),0]){
                    translate([0,0,0])cylinder(r1=bottom_r, r2=radius, h=bottom);
                    translate([0,0,bottom]) cylinder(r=radius,h=size[2]-top-bottom);
                    translate([0,0,size[2]-top]) cylinder(r1=radius, r2=top_r, h=top);
                }
            }
        }
    }
}

//!column();

module column(
    d = 10,
    h = 40,
    notch_h = 20
    
){
    scale([1,0.8,1]) difference(){
        union(){
            cylinder(r1=0, r2=d/2, h=d);
            translate([0,0,d]) cylinder(h=h - 2*d, d=d);
            translate([0,0,h-d]) cylinder(r1=d/2, r2=0, h=d);
        }
        if (notch_h >= d){        
            translate([d/2,0,notch_h]) rotate([0,-90,0]) linear_extrude(d) polygon(points = [
                [0,0],
                [0,-d],
                [sqrt(pow(d,2) - pow(d/2,2)),-d/2]
            ]);
        }
    }
}

