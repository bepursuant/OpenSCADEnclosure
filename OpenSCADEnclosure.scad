// bepursuant/OpenSCADEnclosure - Specify your board dimensions, 
// mounting holes, and ports below to get a perfect custom 3d
// printable enclosure. Easy peasy.

$fn = 32;                   //segments for radius

use <lib/PCB.scad>          //pcb model
//use <lib/CubeX.scad>        //cubes with rounded corners
use <lib/RoundedCube.scad>  //cubes with rounded edges
use <lib/FlatBox.scad>      //enclosure with top and bottom sections
use <lib/NutsandBolts.scad> //to model metric screws and holes for them
//use <lib/PortsandHoles.scad>//to model ports and holes

slop = 0.2;			        //spacing between moving sections

// ====== DEFINE THE BOARD ====== //
boardL = 100;
boardW = 30;
boardH = 10;    //thickness of the PCB in mm

boardTopH = 4;   //height of elements on top of PCB in mm
boardBottomH = 4; //height of elements on the bottom of PCB in mm

boardMountingHoles = [ //[mm along board, mm into board, inner diameter]
    [24, 2,  2.5],
    [24, 12, 2.5],
    [47, 2,  2.5],
    [47, 12, 2.5],
];

// ====== CONFIGURE THE ENCLOSURE ====== //
enclosureScrewType = "M4x16";
enclosureScrewOD = _get_head_dia(enclosureScrewType) + 1;

enclosureMargin = [enclosureScrewOD, 0.5, 0.5];//[x,y,z] spacing between board and enclosure walls in mm
enclosureThickness = [2.5+slop, 2.5+slop, 2.5+slop];//[x,y,z] thickness of walls
enclosureRadius = 4;            //radius of the Z-axis corners
enclosureOverlap = 2;         //amount of top and bottom halves that will overlap in mm

standoffs = boardMountingHoles; //defined just like the board mounting holes
standoffH = boardBottomH;


// =========================================== //
// ====== DO NOT MODIFY BELOW THIS LINE ====== //
// =========================================== //

//position for the bottom shell during display
bottomX = 0;
bottomY = 0;
bottomZ = 0;

//position of the PCB
boardX = bottomX + enclosureMargin[0] + enclosureThickness[0];
boardY = bottomY + enclosureMargin[1] + enclosureThickness[1];
boardZ = bottomZ + enclosureMargin[2] + enclosureThickness[2];

//size of enclosure, based on PCB
enclosureL = boardL + (2*enclosureMargin[0]) + (2*enclosureThickness[0]);
enclosureW = boardW + (2*enclosureMargin[1]) + (2*enclosureThickness[1]);
enclosureH = boardBottomH + boardH + boardTopH + (2*enclosureMargin[2]) + (2*enclosureThickness[2]);
echo(Enclosure=enclosureL,enclosureW,enclosureH);

//position of top shell during display
topX = bottomX;
topY = bottomY;
topZ = 2*(bottomZ + enclosureH/2)-enclosureOverlap;



//build the PCB in-place at 0,0,0
module _board(boardOnly=false){
    PCB(boardL, boardW, boardH, boardBottomH, boardTopH, boardOnly);
}

//build the PCB and move to it's display position
module board(boardOnly=false){
    translate([boardX, boardY, boardZ])
        _board(boardOnly);      
}

module board_standoffs(){
    //build the standoffs for the board
    translate([boardX, boardY, enclosureThickness[2]]){

        for(i = standoffs){
            Standoff(i[0], i[1], 0, standoffH, i[2]);
        }
    }
}

module enclosure_standoffs(half="top"){
    //build the enclosure standoffs
    r = enclosureScrewOD/2 + (enclosureThickness[2]/2) + slop;

    if(half=="top"){
        translate([r, r])
            cylinder(r=enclosureScrewOD/2, h=(enclosureH-enclosureOverlap)/2);
        translate([r, enclosureW-r])
            cylinder(r=enclosureScrewOD/2, h=(enclosureH-enclosureOverlap)/2);
        translate([enclosureL-r, r])
            cylinder(r=enclosureScrewOD/2, h=(enclosureH-enclosureOverlap)/2);
        translate([enclosureL-r, enclosureW-r])
            cylinder(r=enclosureScrewOD/2, h=(enclosureH-enclosureOverlap)/2);
    }else{
        translate([r, r])
            cylinder(r=enclosureScrewOD/2, h=(enclosureH+enclosureOverlap)/2);
        translate([r, enclosureW-r])
            cylinder(r=enclosureScrewOD/2, h=(enclosureH+enclosureOverlap)/2);
        translate([enclosureL-r, r])
            cylinder(r=enclosureScrewOD/2, h=(enclosureH+enclosureOverlap)/2);
        translate([enclosureL-r, enclosureW-r])
            cylinder(r=enclosureScrewOD/2, h=(enclosureH+enclosureOverlap)/2);
    }




}

module _screws(){
    r = enclosureScrewOD/2 + (enclosureThickness[0]/2) + slop;

    translate([r, r])
        _one_screw();

    translate([enclosureL-r, r])
        _one_screw();

    translate([enclosureL-r, enclosureW-r])
        _one_screw();

    translate([r, enclosureW-r])
        _one_screw();
}

module screws(flip=false){
    if(flip){
        translate([enclosureL/2,enclosureW/2,enclosureH/2])
            rotate([0,180,0])
                translate([-enclosureL/2,-enclosureW/2,-enclosureH/2]){
                    _screws();
        }
    }else{
        _screws(); 
    }
}


module _one_screw(){
    rotate([180,0,0]){
        translate([0,0,-_get_head_height(enclosureScrewType)]){
            screw(enclosureScrewType,thread="no");
        }
    }
}

//build the bottom shell in place at 0,0,0
module _bottom(){
    difference(){
        union(){
            board_standoffs();
            enclosure_standoffs(half="bottom");

            FlatBox(enclosureL, enclosureW, enclosureH, enclosureThickness, enclosureRadius, enclosureOverlap, slop, "bottom");
        }
        screws(true);
    }
}

//build the bottom shell and move to it's display position
module bottom(){
    translate([bottomX, bottomY, bottomZ]){
        _bottom();
    }
}

module _top(){
    difference(){
        union(){
            enclosure_standoffs("top");
            FlatBox(enclosureL, enclosureW, enclosureH, enclosureThickness, enclosureRadius, enclosureOverlap, slop, "top");
        }

        screws();
    }
}

module top(){
    translate([topX, topY, topZ]){
        mirror([0, 0, 1]){
            _top();
        }
    }
}

module print(){
    bottom();

    topX = bottomX;
    topY = bottomY + enclosureW + 3;
    topZ = bottomZ;

    translate([topX, topY, topZ])
        _top();
}

//board();

//bottom();

//_top();

print();