// bepursuant/OpenSCADEnclosure - Specify your board dimensions, 
// mounting holes, and ports below to get a perfect custom 3d
// printable enclosure. Easy peasy.

use <lib/PCB.scad>          //pcb model
use <lib/CubeX.scad>        //cubes with rounded corners
use <lib/RoundedCube.scad>  //cubes with rounded edges
use <lib/FlatBox.scad>      //enclosure with top and bottom sections
use <lib/NutsandBolts.scad> //to model metric screws and holes for them

$fn = 32;			        //segments for radius

slop = 0.3;			        //spacing between moving sections


// ====== DEFINE THE BOARD ====== //
boardL = 52;
boardW = 71;
boardH = 1.75;  //thickness of the PCB in mm

boardTopH = 18;     //height of elements on top of PCB in mm
boardBottomH = 3.5; //height of elements on the bottom of PCB in mm

boardMountingHoles =[[3,    3,      2],  //[mm along board, mm into board, inner diameter]
                     [28.5, 3,      2],
                     [35.5, 1.5,    2],
                     [49,   1.5,    2],
                     [3,    67,     2],    //top row
                     [28.5, 67,     2],
                     [35.5, 68.5,   2],
                     [49,   68.5,   2]];


// ====== DEFINE THE ENCLOSURE ====== //
//for the screw closure
enclosureScrewType = "M4x20";
enclosureScrewStandoffOD = _get_head_dia(enclosureScrewType) + 2;

enclosureMargin = 2 + enclosureScrewStandoffOD;        //spacing between board and enclosure walls in mm
enclosureThickness = 1.5;   //thickness of the walls and top/bottom
enclosureRadius = 5;        //radius of the Z-axis corners
enclosureOverlap = 1.25;    //amount of top and bottom halves that will overlap in mm

standoffs = boardMountingHoles;//defined just like the board mounting holes
standoffH = 2 + boardBottomH;



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

module standoffs(){
    //build the standoffs for the board
    for(i = standoffs){
        Standoff(i[0], i[1], 0, standoffH, i[2]);
    }
}

module screws(flip=false){
    r = enclosureScrewStandoffOD/2 + (enclosureThickness/2) + slop;

    translate([r, r])
        _one_screw(flip);

    translate([enclosureL-r, r])
        _one_screw(flip);

    translate([enclosureL-r, enclosureW-r])
        _one_screw(flip);

    translate([r, enclosureW-r])
        _one_screw(flip);
}

module _one_screw(flip=false){
            if(flip){
                translate([0, 0, _get_head_height(enclosureScrewType)]){
                    rotate([180,0,0]){
                        screw(enclosureScrewType);
                    }
                }
            }
            else{
                    mirror([0, 0, 1]){

                translate([0, 0, -_get_head_height(enclosureScrewType)]){
                    screw(enclosureScrewType);
                }
            }
    }
}

module screw_standoffs(){
    r = enclosureScrewStandoffOD/2 + (enclosureThickness/2) + slop;

    translate([r, r])
        cylinder(r=enclosureScrewStandoffOD/2, h=(enclosureH/2)-enclosureOverlap, centered=true);

    translate([enclosureL-r, r])
        cylinder(r=enclosureScrewStandoffOD/2, h=(enclosureH/2)-enclosureOverlap, centered=true);

    translate([enclosureL-r, enclosureW-r])
        cylinder(r=enclosureScrewStandoffOD/2, h=(enclosureH/2)-enclosureOverlap, centered=true);

    translate([r, enclosureW-r])
        cylinder(r=enclosureScrewStandoffOD/2, h=(enclosureH/2)-enclosureOverlap, centered=true);
}


//build the bottom shell in place at 0,0,0
module _bottom(){
    difference(){
        union(){
            translate([boardX, boardY, boardZ-enclosureMargin]){
                standoffs(standoffs, standoffH);
            }

            screw_standoffs();

            FlatBox(enclosureL, enclosureW, enclosureH, enclosureThickness, enclosureRadius, enclosureOverlap, slop, "bottom");
        }
        screws();
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
            screw_standoffs();
            FlatBox(enclosureL, enclosureW, enclosureH, enclosureThickness, enclosureRadius, enclosureOverlap, slop, "top");
        }

        screws(true);
    }
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

//print();

_one_screw();