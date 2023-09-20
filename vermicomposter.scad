$fn=100;

vermicomposter();

module vermicomposter(
    size = [210, 210, 100],
    r = 15,
    con = 5,
    bottom = [2,2,20],
    column_d = 6,
    column_s = 3,  // column separation
    holes_mt = 25,
    holes_var = 12.5
){
    box(size, r, con, bottom);
    
    columnT = column_d + column_s;
    columnsL = floor((size[0] - 2*r) / columnT);
    offsetL = -(columnsL * columnT - columnT)/2;
    
    
    column_h = size[2] - con - bottom[2];
    z =bottom[2] + con;
    
    for(a = [0 : columnsL - 1]){
        n = a%2 ? holes_mt : holes_mt + holes_var;
        x = offsetL + a * columnT;
        
        translate([x,-size[1]/2,z])
            column(column_d, column_h, n);
        translate([x,size[1]/2,z]) 
            rotate(180) column(column_d, column_h, n);
    }
    
    columnsW = floor((size[1] - 2*r) / columnT);
    offsetW = -(columnsW * columnT - columnT)/2;
    
    for(a = [0 : columnsW - 1]){
        n = a%2 ? holes_mt : holes_mt + holes_var;
        y = offsetW + a * columnT;
        
        translate([-size[0]/2,y,z]) 
            rotate(-90) column(column_d, column_h, n);
        translate([size[0]/2,y,z]) 
            rotate(90) column(column_d, column_h, n);
    }
    
}

module box(
    size = [210, 210, 100],
    r = 15,
    con = 6,
    bottom = [1,1,20]
){  
        translate([0,0,bottom[2]+con]) linear_extrude(size[2]-con-bottom[2]) hull(){
            x = (size[0] - 2*r)/2;
            y = (size[1] - 2*r)/2;
            translate([-x,-y,0]) circle(r=r);
            translate([-x,y,0]) circle(r=r);
            translate([x,-y,0]) circle(r=r);
            translate([x,y,0]) circle(r=r);
        }
    
        b0 = size[0] - bottom[0];
        b1 = size[1] - bottom[1];
        
        translate([0,0,bottom[2]]) linear_extrude(con, scale=[
            size[0]/b0,
            size[1]/b1
        ]) hull() {
            x = (b0 - 2*r)/2;
            y = (b1 - 2*r)/2;
            
            translate([-x,-y,0]) circle(r=r);
            translate([-x,y,0]) circle(r=r);
            translate([x,-y,0]) circle(r=r);
            translate([x,y,0]) circle(r=r);
        }
        
        
        linear_extrude(bottom[2]) hull(){
            x = (b0 - 2*r)/2;
            y = (b1 - 2*r)/2;
            translate([-x,-y,0]) circle(r=r);
            translate([-x,y,0]) circle(r=r);
            translate([x,-y,0]) circle(r=r);
            translate([x,y,0]) circle(r=r);
       
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