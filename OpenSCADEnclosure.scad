// bepursuant/OpenSCADEnclosure - Specify your board dimensions, 
// mounting holes, and ports below to get a perfect custom 3d
// printable enclosure. Easy peasy.

use <lib/CubeX.scad>        //cubes with rounded corners
use <lib/RoundedCube.scad>  //cubes with rounded edges
use <lib/FlatBox.scad>      //enclosure with top and bottom sections

$fn = 36;			        //segments for radius

slop = 0.3;			        //spacing between moving sections


// ====== DEFINE THE BOARD BELOW ====== //
boardL = 32;
boardW = 70;
boardH = 1.75;  //thickness of the PCB in mm
boardTop = 14;  //height of elements on top of PCB in mm
boardBottom = 3;//height of elements on the bottom of PCB in mm

// Locate each mounting hole in the board to auto create holes and standoffs
// on the bottom section of the enclosure. Use the syntax for each hole
// of = [distance along board X, distance along board Y, [TODO: ID]]
mountingHoleID = 2;
mountingHoles =[[2.75,  2.75],
                [2.75,  28.5],
                [67,    2.75],
                [67,    28.5]];

// ====== SETUP ENCLOSURE PARAMETERS BELOW ====== //
enclosureInsideMargin = 2; //distance between all board elements and enclosure walls in mm
enclosureWallThickness = 1.5;

/*enclosureBottomOutsideL = boardL + (2*insideMargin) + (2*wallThickness);
enclosureBottomOutsideW = boardW + (2*insideMargin) + (2*wallThickness);
enclosureBottomOutsideH = boardBottom + boardH + boardTop + insideMargin + wallThickness;
*/

// Draw the board with given parameters
module board(boardOnly=false){
    if(!boardOnly){
        //bottom
        color("GREY", 0.5){
            cube(size=[boardW, boardL, boardBottom]);
        }
    }

    //pcb
    color("GREEN"){ 
        translate([0, 0, boardBottom]){
            difference(){
                cube(size=[boardW, boardL, boardH]);
                
                for(i = mountingHoles){
                    translate([i[0], i[1], -0.1]){
                        cylinder(r=mountingHoleID/2, h=boardH+0.2);
                    }
                }
            }
        }
    }

    if(!boardOnly){       
        //top
        color("GREY", 0.5){
            translate([0, 0, boardBottom + boardH]){
                cube(size=[boardW, boardL, boardTop]);
            }
        }
    }
}

module enclosure_bottom(){

    //cubeX(size=[], radius=);

}

/*module standoff(height, ID, OD){    //build a single standoff
   translate([0, 0,height/2]){
       difference(){
            cube(size=[OD, OD, height], center=true);
            cylinder(r=ID/2, h=height, center=true);
        }
    }
}*/

board();