module PCB(length, width, thickness, bottomHeight, topHeight, boardOnly=false){
    if(!boardOnly){
        //bottomHeight
        color("GREY", 0.5){
            cube(size=[length, width, bottomHeight]);
        }
    }

    //pcb
    color("GREEN"){ 
        translate([0, 0, bottomHeight]){
            difference(){
                cube(size=[length, width, thickness]);
                
                for(i = mountingHoles){
                    translate([i[0], i[1], -0.1]){
                        cylinder(r=i[2]/2, h=thickness+0.2);
                    }
                }
            }
        }
    }

    if(!boardOnly){       
        //top
        color("GREY", 0.5){
            translate([0, 0, bottomHeight + thickness]){
                cube(size=[length, width, topHeight]);
            }
        }
    }
}

module Standoff(x=0, y=0, z=0, height, ID){    //build a single standoff
   translate([x, y, z]){
       translate([0, 0,height/2]){
           difference(){
                cylinder(r=(ID/2.1)+1.4, h=height, center=true);  //OD
                cylinder(r=ID/2.1, h=height+3, center=true);  //ID
            }
        }
    }
}