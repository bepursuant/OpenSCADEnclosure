// bepursuant/OpenSCADEnclosure - Specify your board dimensions, 
// mounting holes, and ports below to get a perfect custom 3d
// printable enclosure. Easy peasy.

use <lib/PCB.scad>          //pcb model
use <lib/CubeX.scad>        //cubes with rounded corners
use <lib/RoundedCube.scad>  //cubes with rounded edges
use <lib/FlatBox.scad>      //enclosure with top and bottom sections

$fn = 36;			        //segments for radius

slop = 0.3;			        //spacing between moving sections


// ====== DEFINE THE BOARD BELOW ====== //
boardL = 52;// + 1 + 17;
boardW = 71;
boardH = 1.75;  //thickness of the PCB in mm

boardTop = 18;  //height of elements on top of PCB in mm
boardBottom = 3.5;//height of elements on the bottom of PCB in mm

boardMountingHoles =[[3,    3,      2],  //[mm along board, mm into board, diameter]
                     [28.5, 3,      2],
                     [35.5, 1.5,    2],
                     [49,   1.5,    2],
                     [3,    67,     2],    //top row
                     [28.5, 67,     2],
                     [35.5, 68.5,   2],
                     [49,   68.5,   2]];


// ====== SETUP ENCLOSURE PARAMETERS BELOW ====== //
enclosureMargin = 2; //distance between all board elements and enclosure walls in mm
enclosureThickness = 1.5;
enclosureRadius = 5;
enclosureOverlap = 2;   //mm of overlap on top and bottom

standoffs = boardMountingHoles;
standoffH = enclosureMargin + boardBottom;

// ************ CALCULATIONS BELOW **************************
bottomX = 0;
bottomY = 0;
bottomZ = 0;

boardX = bottomX + enclosureThickness + enclosureMargin;
boardY = bottomY + enclosureThickness + enclosureMargin;
boardZ = bottomZ + enclosureThickness + enclosureMargin;

enclosureL = boardL + (2*enclosureMargin) + (2*enclosureThickness);
enclosureW = boardW + (2*enclosureMargin) + (2*enclosureThickness);
enclosureH = boardBottom + boardH + boardTop + (2*enclosureMargin) + (2*enclosureThickness);

topX = bottomX;
topY = bottomY;
topZ = 2*(bottomZ + enclosureH/2)-enclosureOverlap;

module _board(boardOnly=false){
    PCB(boardL, boardW, boardH, boardBottom, boardTop, boardOnly);
}

module board(boardOnly=false){
    translate([boardX, boardY, boardZ])
        _board(boardOnly);      
}

module _bottom(){
    FlatBox(enclosureL, enclosureW, enclosureH, enclosureThickness, enclosureRadius, enclosureOverlap, "bottom");
}

module bottom(){
    translate([bottomX, bottomY, bottomZ]){
        union(){
            translate([boardX, boardY, boardZ-enclosureMargin]){
                standoffs();
            }

            _bottom();
        }
    }
}

module standoffs(){
    for(i = standoffs){
        Standoff(i[0], i[1], 0, standoffH, i[2]);
    } 
}

module _top(){
    FlatBox(enclosureL, enclosureW, enclosureH, enclosureThickness, enclosureRadius, enclosureOverlap, "top");
}

module top(){
    translate([topX, topY, topZ])
        mirror([0, 0, 1])
            _top();
}

//board(true);
_top();
//bottom();