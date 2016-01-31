// bepursuant/OpenSCADEnclosure - Specify your board dimensions, 
// mounting holes, and ports below to get a perfect custom 3d
// printable enclosure. Easy peasy.

use <lib/roundedRect.scad>  //cubes with rounded edges

$fn = 36;			        //segments for radius

slop = 0.3;			        //spacing between moving sections


// ====== DEFINE THE BOARD BELOW ====== //
boardL = 32;
boardW = 70;
boardH = 1.75;  //thickness of the PCB in mm
boardTop = 14;  //height of elements on top of PCB in mm
boardBottom = 3;//height of elements on the bottom of PCB in mm

// ====== LOCATE YOUR MOUNTING STANDOFFS BELOW ====== //
// These are referenced in relation to the board, so the parameters
// are length along the board, and depth into the board

/*holeID = 2;
holes = [   [2.75,  2.75],
			[2.75,  28.5],
			[67,    2.75],
            [67,    28.5]   ];

standoffID = 1.75;
standoffOD = 2.5;
standoffH = boardBottom + 5;
standoffs = holes;*/


// ====== SETUP ENCLOSURE PARAMETERS BELOW ====== //
/*insideMargin = 2; //distance between all board elements and enclosure walls in mm
wallThickness = 1.5;

enclosureBottomOutsideL = boardL + (2*insideMargin) + (2*wallThickness);
enclosureBottomOutsideW = boardW + (2*insideMargin) + (2*wallThickness);
enclosureBottomOutsideH = boardBottom + boardH + boardTop + insideMargin + wallThickness;
*/

// Draw the board with given parameters
module board(boardOnly=false){
    union(){
        
        //pcb
        color("GREEN"){ 
            translate([0, 0, boardBottom]){
                difference(){
                    cube(size=[boardW, boardL, boardH]);
                    
                    /*union(){
                        for(i = holes){
                            translate([i[0], i[1], -0.1]){
                                cylinder(r=holeID/2, h=boardH+0.2);
                            }
                        }
                    }*/
                }
            }
        }

        if(!boardOnly){
            //bottom
            color("GREY", 0.5){
                cube(size=[boardW, boardL, boardBottom]);
            }
            
            //top
            color("GREY", 0.5){
                translate([0, 0, boardBottom + boardH]){
                    cube(size=[boardW, boardL, boardTop]);
                }
            }
        }
    }
}

/*module buildStandoffs(){
    for(i = standoffs){
        translate([i[0], i[1], 0]){
            standoff(standoffH, standoffID, standoffOD);
        }
    } 
}

module standoff(height, ID, OD){
    translate([0,0,height/2]){
        difference(){
            cylinder(r=OD/2, h=height, center=true);
            cylinder(r=ID/2, h=height, center=true);
        }
    }
}

module bottomSection(){
    //difference
    
    //cube outside
    cube([enclosureBottomOutsideW, enclosureBottomOutsideL, enclosureBottomOutsideH]);
    
    //cube inside
    
    //add standoffs
    
}
*/

board();
//buildStandoffs();
//bottomSection();