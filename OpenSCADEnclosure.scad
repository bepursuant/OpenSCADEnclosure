// bepursuant/OpenSCADEnclosure - Specify your board dimensions, 
// mounting holes, and ports below to get a perfect custom 3d
// printable enclosure. Easy peasy.

use <lib/PCB.scad>          //pcb model
use <lib/CubeX.scad>        //cubes with rounded corners
use <lib/RoundedCube.scad>  //cubes with rounded edges
use <lib/FlatBox.scad>      //enclosure with top and bottom sections

$fn = 36;			        //segments for radius

slop = 0.3;			        //spacing between moving sections


// ====== DEFINE THE BOARD ====== //
boardL = 52;
boardW = 71;
boardH = 1.75;  //thickness of the PCB in mm

boardTopH = 18;     //height of elements on top of PCB in mm
boardBottomH = 3.5; //height of elements on the bottom of PCB in mm

boardMountingHoles =[[3,    3,      2],  //[mm along board, mm into board, diameter]
                     [28.5, 3,      2],
                     [35.5, 1.5,    2],
                     [49,   1.5,    2],
                     [3,    67,     2],    //top row
                     [28.5, 67,     2],
                     [35.5, 68.5,   2],
                     [49,   68.5,   2]];


// ====== DEFINE THE ENCLOSURE ====== //
enclosureMargin = 2;        //spacing between board and enclosure walls in mm
enclosureThickness = 1.5;   //thickness of the walls and top/bottom
enclosureRadius = 5;        //radius of the Z-axis corners
enclosureOverlap = 1.25;       //amount of top and bottom halves that will overlap in mm

standoffs = boardMountingHoles;//defined just like the board mounting holes
standoffH = enclosureMargin + boardBottomH;



// ====== DO NOT MODIFY BELOW THIS LINE ====== //

//position of the bottom shell during display
bottomX = 0;
bottomY = 0;
bottomZ = 0;

//position of the PCB
boardX = bottomX + enclosureThickness + enclosureMargin;
boardY = bottomY + enclosureThickness + enclosureMargin;
boardZ = bottomZ + enclosureThickness + enclosureMargin;

//size of enclosure, based on PCB
enclosureL = boardL + (2*enclosureMargin) + (2*enclosureThickness);
enclosureW = boardW + (2*enclosureMargin) + (2*enclosureThickness);
enclosureH = boardBottomH + boardH + boardTopH + (2*enclosureMargin) + (2*enclosureThickness);

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

module standoffs(){
    for(i = standoffs){
        Standoff(i[0], i[1], 0, standoffH, i[2]);
    } 
}

//build the bottom shell in place at 0,0,0
module _bottom(){
    union(){
        translate([boardX, boardY, boardZ-enclosureMargin]){
            standoffs(standoffs, standoffH);
        }

        FlatBox(enclosureL, enclosureW, enclosureH, enclosureThickness, enclosureRadius, enclosureOverlap, slop, "bottom");
    }
}

//build the bottom shell and move to it's display position
module bottom(){
    translate([bottomX, bottomY, bottomZ]){
        _bottom();
    }
}

module _top(){
    FlatBox(enclosureL, enclosureW, enclosureH, enclosureThickness, enclosureRadius, enclosureOverlap, slop, "top");
}

module top(){
    translate([topX, topY, topZ])
        mirror([0, 0, 1])
            _top();
}

module print(){
    _bottom();

    topX = bottomX + enclosureL + 5;
    topY = bottomY;
    topZ = bottomZ;

    translate([topX, topY, topZ])
        _top();
}

//board(true);
//top();
//bottom();

print();