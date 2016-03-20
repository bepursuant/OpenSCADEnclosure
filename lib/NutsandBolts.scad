// Norm Nuts and Bolts - a OpenSCAD library
// Copyright (C) 2012  Johannes Kneer

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// DATABASE ACCESS FUNCTIONS AND CONSTANTS



// == CONSTANTS == 

// screw table access keys
_NB_S_DESC            = 0;
_NB_S_FAMKEY			 = 1;
_NB_S_LENGTH          = 2;
_NB_S_NOTHREAD_LENGTH = 3;

_NB_F_DESC			 = 0;
_NB_F_OUTER_DIA       = 1;
_NB_F_INNER_DIA       = 2;
_NB_F_LEAD            = 3; 
_NB_F_KEY             = 4;
_NB_F_KEY_DEPTH       = 5;
_NB_F_HEAD_HEIGHT     = 6;
_NB_F_HEAD_DIA        = 7;
_NB_F_NUT_KEY         = 8;
_NB_F_NUT_HEIGHT      = 9;


// == FUNCTIONS ==

// _get_screw("descriptor")   with descriptor = M8x25
//   find the line for a general object in the data matrix

function _get_screw(n) = data_screw[search([n], data_screw)[0]];
function _get_screw_fam(n) = data_screw_fam[search([_get_screw(n)[_NB_S_FAMKEY]], data_screw_fam)[0]];

function _get_fam(n) = data_screw_fam[search([n], data_screw_fam)[0]];


// _get_XXXXX("descriptor") functions
// find a single property in the database

function _get_desc(n)        = _get_screw(n)[_NB_S_DESC];
function _get_famkey(n)         = _get_screw(n)[_NB_S_FAMKEY];
function _get_length(n)      = _get_screw(n)[_NB_S_LENGTH];
function _get_nt_length(n)   = _get_screw(n)[_NB_S_NOTHREAD_LENGTH];

function _get_outer_dia(n)   = _get_screw_fam(n)[_NB_F_OUTER_DIA];
function _get_inner_dia(n)   = _get_screw_fam(n)[_NB_F_INNER_DIA];
function _get_lead(n)        = _get_screw_fam(n)[_NB_F_LEAD];
function _get_head_height(n) = _get_screw_fam(n)[_NB_F_HEAD_HEIGHT];
function _get_head_dia(n)    = _get_screw_fam(n)[_NB_F_HEAD_DIA];
function _get_nut_key(n)     = _get_screw_fam(n)[_NB_F_NUT_KEY];
function _get_nut_height(n)  = _get_screw_fam(n)[_NB_F_NUT_HEIGHT];

// DATA FILE FOR METRIC BOLTS AND NUTS


// Bolts with HEXAGON SOCKET HEAD CAP SCREWS
// Schrauben mit Zylinderkopf mit Innensechskant

// the modeled bolt is similar to DIN 912 and DIN EN ISO 4762 bolts
// the modeled nut is similar DIN EN ISO 4032



// == screw family table ==
// properties common for a whole screw family
// also including head height and nut height

data_screw_fam = [
// desc, th_outerdia, th_innerdia, lead, key, key_depth, head_height, head_dia, nut_key, nut_height
["M1.6", 1.6, "xx", 0.35, 1.5,  0.7, 1.6,   3, 3.2,  1.3],
["M2",	   2, "xx",  0.4, 1.5,    1,   2, 3.8,   4,  1.6],
["M2.5", 2.5, "xx", 0.45,   2,  1.1, 2.5, 4.5,   5,    2],
["M3",     3, "xx",  0.5, 2.5,  1.3,   3, 5.5, 5.5,  2.4],
["M4",     4, "xx",  0.7,   3,    2,   4,   7,   7,  3.2],
["M5",     5, "xx",  0.8,   4,  2.5,   5, 8.5,   8,  4.7],
["M6",     6, "xx",    1,   5,    3,   6,  10,  10,  5.2],
["M8",     8, "xx", 1.25,   6,    4,   8,  13,  13,  6.8],
["M10",   10, "xx",  1.5,   8,    5,  10,  16,  16,  8.4],
["M12",   12, "xx", 1.75,  10,    6,  12,  18,  18, 10.8],
["M16",   16, "xx",    2,  14,    8,  16,  24,  24, 14.8],
["M20",   20, "xx",  2.5,  17,   10,  20,  30,  30,   18],
["M24",   24, "xx",    3,  19,   12,  24,  36,  36, 21.5],
["M30",   30, "xx",  3.5,  22, 15.5,  30,  45,  46, 25.6],
["M36",   36, "xx",    4,  27,   19,  36,  54,  55,   31],
["M42",   42, "xx",  4.5,  32,   24,  42,  63,  65,   34],
["M48",   48, "xx",    5,  36,   28,  48,  72,  75,   38],
["M56",   56, "xx",  5.5,  41,   34,  56,  84,  85,   45],
["M64",   64, "xx",    6,  46,   38,  64,  96,  95,   51],
["M1.6t", 1.6, "xx", 0.35, 1.5,  0.7, 1.6,   3, 3.2,  1],
["M2t",	   2, "xx",  0.4, 1.5,    1,   2, 3.8,   4,  1.2],
["M2.5t", 2.5, "xx", 0.45,   2,  1.1, 2.5, 4.5,   5,    1.6],
["M3t",     3, "xx",  0.5, 2.5,  1.3,   3, 5.5, 5.5,  1.8],
["M4t",     4, "xx",  0.7,   3,    2,   4,   7,   7,  2.2],
["M5t",     5, "xx",  0.8,   4,  2.5,   5, 8.5,   8,  2.7],
["M6t",     6, "xx",    1,   5,    3,   6,  10,  10,  3.2],
["M8t",     8, "xx", 1.25,   6,    4,   8,  13,  13,  4.0],
["M10t",   10, "xx",  1.5,   8,    5,  10,  16,  16,  5.0],
["M12t",   12, "xx", 1.75,  10,    6,  12,  18,  18,  6.0],
["M16t",   16, "xx",    2,  14,    8,  16,  24,  24,  8.0],
["M20t",   20, "xx",  2.5,  17,   10,  20,  30,  30, 10.0],
["M24t",   24, "xx",    3,  19,   12,  24,  36,  36, 12.0],
["M30t",   30, "xx",  3.5,  22, 15.5,  30,  45,  46, 15.0],
["M36t",   36, "xx",    4,  27,   19,  36,  54,  55, 18.0],
["M42t",   42, "xx",  4.5,  32,   24,  42,  63,  65, 21.0],
["M48t",   48, "xx",    5,  36,   28,  48,  72,  75, 24.0],
["M56t",   56, "xx",  5.5,  41,   34,  56,  84,  85, 28.0],
["M64t",   64, "xx",    6,  46,   38,  64,  96,  95, 32.0]
];


// == screw table ==
// properties for individual screws

data_screw = [
// desc, family, length, noth_length 
// M1.6
["M1.6x2.5", "M1.6", 2.5, 0],
["M1.6x3",   "M1.6",   3, 0],
["M1.6x4",   "M1.6",   4, 0],
["M1.6x5",   "M1.6",   5, 0],
["M1.6x6",   "M1.6",   6, 0],
["M1.6x8",   "M1.6",   8, 0],
["M1.6x10",  "M1.6",  10, 0],
["M1.6x12",  "M1.6",  12, 0],
["M1.6x16",  "M1.6",  16, 0],

// M2
["M2x3",  "M2",    3, 0],
["M2x4",  "M2",    4, 0],
["M2x5",  "M2",    5, 0],
["M2x6",  "M2",    6, 0],
["M2x8",  "M2",    8, 0],
["M2x10", "M2",   10, 0],
["M2x12", "M2",   12, 0],
["M2x16", "M2",   16, 0],
["M2x20", "M2",   20, 2],

// M2.5
["M2.5x4",  "M2.5",    4,    0],
["M2.5x5",  "M2.5",    5,    0],
["M2.5x6",  "M2.5",    6,    0],
["M2.5x8",  "M2.5",    8,    0],
["M2.5x10", "M2.5",   10,    0],
["M2.5x12", "M2.5",   12,    0],
["M2.5x16", "M2.5",   16,    0],
["M2.5x20", "M2.5",   20,    0],
["M2.5x25", "M2.5",   25, 5.75],

// M3
["M3x5",  "M3",    5,   0],
["M3x6",  "M3",    6,   0],
["M3x8",  "M3",    8,   0],
["M3x10", "M3",   10,   0],
["M3x12", "M3",   12,   0],
["M3x16", "M3",   16,   0],
["M3x20", "M3",   20,   0],
["M3x25", "M3",   25, 4.5],
["M3x30", "M3",   30, 9.5],

// M4
["M4x6",  "M4",    6,    0],
["M4x8",  "M4",    8,    0],
["M4x10", "M4",   10,    0],
["M4x12", "M4",   12,    0],
["M4x16", "M4",   16,    0],
["M4x20", "M4",   20,    0],
["M4x25", "M4",   25,    0],
["M4x30", "M4",   30,  6.5],
["M4x35", "M4",   35, 11.5],
["M4x40", "M4",   40, 16.5],

// M5
["M5x8",  "M5",    8,  0],
["M5x10", "M5",   10,  0],
["M5x12", "M5",   12,  0],
["M5x16", "M5",   16,  0],
["M5x20", "M5",   20,  0],
["M5x25", "M5",   25,  0],
["M5x30", "M5",   30,  4],
["M5x35", "M5",   35,  9],
["M5x40", "M5",   40, 14],
["M5x45", "M5",   45, 19],
["M5x50", "M5",   50, 24],

// M6
["M6x8",  "M6",    8,  0],
["M6x10", "M6",   10,  0],
["M6x12", "M6",   12,  0],
["M6x16", "M6",   16,  0],
["M6x20", "M6",   20,  0],
["M6x25", "M6",   25,  0],
["M6x30", "M6",   30,  0],
["M6x35", "M6",   35,  6],
["M6x40", "M6",   40, 11],
["M6x45", "M6",   45, 16],
["M6x50", "M6",   50, 21],
["M6x55", "M6",   56, 26],
["M6x60", "M6",   60, 31],

// M8
["M8x12", "M8",   12,     0],
["M8x16", "M8",   16,     0],
["M8x20", "M8",   20,     0],
["M8x25", "M8",   25,     0],
["M8x30", "M8",   30,     0],
["M8x35", "M8",   35,     0],
["M8x40", "M8",   40,  5.75],
["M8x45", "M8",   45, 10.75],
["M8x50", "M8",   50, 15.75],
["M8x55", "M8",   55, 20.75],
["M8x60", "M8",   60, 25.75],
["M8x65", "M8",   65, 30.75],
["M8x70", "M8",   70, 35.75],
["M8x80", "M8",   80, 45.75],

// M10
["M10x16",  "M10",   16,    0],
["M10x20",  "M10",   20,    0],
["M10x25",  "M10",   25,    0],
["M10x30",  "M10",   30,    0],
["M10x35",  "M10",   35,    0],
["M10x40",  "M10",   40,    0],
["M10x45",  "M10",   45,  5.5],
["M10x50",  "M10",   50, 10.5],
["M10x55",  "M10",   55, 15.5],
["M10x60",  "M10",   60, 20.5],
["M10x65",  "M10",   65, 25.5],
["M10x70",  "M10",   70, 30.5],
["M10x80",  "M10",   80, 40.5],
["M10x90",  "M10",   90, 50.5],
["M10x100", "M10", 100, 60.5],

// M12
["M12x20",  "M12",  20,     0],
["M12x25",  "M12",  25,     0],
["M12x30",  "M12",  30,     0],
["M12x35",  "M12",  35,     0],
["M12x40",  "M12",  40,     0],
["M12x45",  "M12",  45,     0],
["M12x50",  "M12",  50,     0],
["M12x55",  "M12",  55, 10.25],
["M12x60",  "M12",  60, 15.25],
["M12x65",  "M12",  65, 20.25],
["M12x70",  "M12",  70, 25.25],
["M12x80",  "M12",  80, 35.25],
["M12x90",  "M12",  90, 45.25],
["M12x100", "M12", 100, 55.25],
["M12x110", "M12", 110, 65.25],
["M12x120", "M12", 120, 75.25],

// M16
["M16x25",  "M16",  25,   0],
["M16x30",  "M16",  30,   0],
["M16x35",  "M16",  35,   0],
["M16x40",  "M16",  40,   0],
["M16x45",  "M16",  45,   0],
["M16x50",  "M16",  50,   0],
["M16x55",  "M16",  55,   0],
["M16x60",  "M16",  60,   0],
["M16x65",  "M16",  65,  11],
["M16x70",  "M16",  70,  16],
["M16x80",  "M16",  80,  26],
["M16x90",  "M16",  90,  36],
["M16x100", "M16", 100,  46],
["M16x110", "M16", 110,  56],
["M16x120", "M16", 120,  66],
["M16x130", "M16", 130,  76],
["M16x140", "M16", 140,  86],
["M16x150", "M16", 150,  96],
["M16x160", "M16", 160, 106],

// M20
["M20x30",  "M20",  30,     0],
["M20x35",  "M20",  35,     0],
["M20x40",  "M20",  40,     0],
["M20x45",  "M20",  45,     0],
["M20x50",  "M20",  50,     0],
["M20x55",  "M20",  55,     0],
["M20x60",  "M20",  60,     0],
["M20x65",  "M20",  65,     0],
["M20x70",  "M20",  70,     0],
["M20x80",  "M20",  80,  15.5],
["M20x90",  "M20",  90,  25.5],
["M20x100", "M20", 100,  35.5],
["M20x110", "M20", 110,  45.5],
["M20x120", "M20", 120,  55.5],
["M20x130", "M20", 130,  65.5],
["M20x140", "M20", 140,  75.5],
["M20x150", "M20", 150,  85.5],
["M20x160", "M20", 160,  95.5],
["M20x180", "M20", 180, 115.5],
["M20x200", "M20", 200, 135.5],

// M24
["M24x40",  "M24",  40,   0],
["M24x45",  "M24",  45,   0],
["M24x50",  "M24",  50,   0],
["M24x55",  "M24",  55,   0],
["M24x60",  "M24",  60,   0],
["M24x65",  "M24",  65,   0],
["M24x70",  "M24",  70,   0],
["M24x80",  "M24",  80,   0],
["M24x90",  "M24",  90,  15],
["M24x100", "M24", 100,  25],
["M24x110", "M24", 110,  35],
["M24x120", "M24", 120,  45],
["M24x130", "M24", 130,  55],
["M24x140", "M24", 140,  65],
["M24x150", "M24", 150,  75],
["M24x160", "M24", 160,  85],
["M24x180", "M24", 180, 105],
["M24x200", "M24", 200, 125],

// M30
["M30x45",  "M30",  45,     0],
["M30x50",  "M30",  50,     0],
["M30x55",  "M30",  55,     0],
["M30x60",  "M30",  60,     0],
["M30x65",  "M30",  65,     0],
["M30x70",  "M30",  70,     0],
["M30x80",  "M30",  80,     0],
["M30x90",  "M30",  90,     0],
["M30x100", "M30", 100,     0],
["M30x110", "M30", 110,  20.5],
["M30x120", "M30", 120,  30.5],
["M30x130", "M30", 130,  40.5],
["M30x140", "M30", 140,  50.5],
["M30x150", "M30", 150,  60.5],
["M30x160", "M30", 160,  70.5],
["M30x180", "M30", 180,  90.5],
["M30x200", "M30", 200, 110.5],

// M36
["M36x55",  "M36",  55,  0],
["M36x60",  "M36",  60,  0],
["M36x65",  "M36",  65,  0],
["M36x70",  "M36",  70,  0],
["M36x80",  "M36",  80,  0],
["M36x90",  "M36",  90,  0],
["M36x100", "M36", 100,  0],
["M36x110", "M36", 110,  0],
["M36x120", "M36", 120, 16],
["M36x130", "M36", 130, 26],
["M36x140", "M36", 140, 36],
["M36x150", "M36", 150, 46],
["M36x160", "M36", 160, 56],
["M36x180", "M36", 180, 76],
["M36x200", "M36", 200, 96],

// M42
["M42x60",  "M42",  60,     0],
["M42x65",  "M42",  65,     0],
["M42x70",  "M42",  70,     0],
["M42x80",  "M42",  80,     0],
["M42x90",  "M42",  90,     0],
["M42x100", "M42", 100,     0],
["M42x110", "M42", 110,     0],
["M42x120", "M42", 120,     0],
["M42x130", "M42", 130,     0],
["M42x140", "M42", 140,  21.5],
["M42x150", "M42", 150,  31.5],
["M42x160", "M42", 160,  41.5],
["M42x180", "M42", 180,  61.5],
["M42x200", "M42", 200,  81.5],
["M42x220", "M42", 220, 101.5],
["M42x240", "M42", 240, 121.5],
["M42x260", "M42", 260, 141.5],
["M42x280", "M42", 280, 161.5],
["M42x300", "M42", 300, 181.5],

// M48
["M48x70",  "M48",  70,   0],
["M48x80",  "M48",  80,   0],
["M48x90",  "M48",  90,   0],
["M48x100", "M48", 100,   0],
["M48x110", "M48", 110,   0],
["M48x120", "M48", 120,   0],
["M48x130", "M48", 130,   0],
["M48x140", "M48", 140,   0],
["M48x150", "M48", 150,   0],
["M48x160", "M48", 160,  27],
["M48x180", "M48", 180,  47],
["M48x200", "M48", 200,  67],
["M48x220", "M48", 220,  87],
["M48x240", "M48", 240, 107],
["M48x260", "M48", 260, 127],
["M48x280", "M48", 280, 147],
["M48x300", "M48", 300, 167],

// M56
["M56x80",  "M56",  80,     0],
["M56x90",  "M56",  90,     0],
["M56x100", "M56", 100,     0],
["M56x110", "M56", 110,     0],
["M56x120", "M56", 120,     0],
["M56x130", "M56", 130,     0],
["M56x140", "M56", 140,     0],
["M56x150", "M56", 150,     0],
["M56x160", "M56", 160,     0],
["M56x180", "M56", 180,  28.5],
["M56x200", "M56", 200,  48.5],
["M56x220", "M56", 220,  68.5],
["M56x240", "M56", 240,  88.5],
["M56x260", "M56", 260, 108.5],
["M56x280", "M56", 280, 128.5],
["M56x300", "M56", 300, 148.5],

// M64
["M64x90",  "M64",  90,   0],
["M64x100", "M64", 100,   0],
["M64x110", "M64", 110,   0],
["M64x120", "M64", 120,   0],
["M64x130", "M64", 130,   0],
["M64x140", "M64", 140,   0],
["M64x150", "M64", 150,   0],
["M64x160", "M64", 160,   0],
["M64x180", "M64", 180,   0],
["M64x200", "M64", 200,  30],
["M64x220", "M64", 220,  50],
["M64x240", "M64", 240,  70],
["M64x260", "M64", 260,  90],
["M64x280", "M64", 280, 110],
["M64x300", "M64", 300, 130]
];



// MAIN LIBRARY MODULES AND FUNCTIONS

// =============================
// -- through hole for screws --
// -----------------------------

module hole_through(

	name = "M3",  // name of screw family (i.e. M4, M5, etc)
	l    = 50.0,  // length of main bolt
	cld  =  0.2,  // dia clearance for the bolt
	h    =  0.0,  // height of bolt-head
	hcld =  1.0)  // dia clearances for the head
{ // -----------------------------------------------

	df = _get_fam(name);
	orad        = df[_NB_F_OUTER_DIA]/2;
	head_height = df[_NB_F_HEAD_HEIGHT];
	head_rad    = df[_NB_F_HEAD_DIA]/2;
	union() {
		translate([0, 0, -l/2-h]) cylinder(r=(orad+cld/2), h=l,  center=true);
		if (h>0)
			translate([0,0,-h/2]) cylinder(r=(head_rad+hcld/2),h=h, center=true);
	}
}
// -- end of hole_through module
// -----------------------------



// =============================
// -- threaded hole           --
// -----------------------------

module hole_threaded(

	name   = "M3",  // name of screw family (i.e. M3, M4, M42, ...)
	l      = 25.0,  // length/depth of hole 
	thread = "no",  // option wheter or not to model the thread
			//   -> no:      hole has inner thread diameter (default)
                        //   -> modeled: actual thread is in the model
        cltd   =  0.0)  // dia clearance to add for thread=no
{ // -----------------------------------------------

	df = _get_fam(name);
	orad        = df[_NB_F_OUTER_DIA]/2;
	lead	    = df[_NB_F_LEAD];
	
	irad = orad-lead;

	
	if (thread=="modeled") {
		translate([0,0,-l]) thread(orad, l, lead);
	} else {
		translate([0,0,-l/2]) cylinder(r=irad+cltd/2,h=l,center=true);
	}
}
// -- end of hole_threaded module
// -----------------------------



// ====================================
// -- nutcatch parallel to bolt axis --
// ------------------------------------

module nutcatch_parallel(

	name   = "M3",  // name of screw family (i.e. M3, M4, ...)
	l      =  5.0,  // length/depth of hole
	clk    =  0.0)  // clearance aditional to nominal key width
{ // -----------------------------------------------

	df     = _get_fam(name);
	nutkey = df[_NB_F_NUT_KEY];

	translate([0,0,-l/2]) hexaprism(ri=nutkey/2+clk/2, h=l);
}
// -- end of nutcatch_parallel module
// -----------------------------



// ========================================
// -- nutcatch cut sideways towards hole --
// ----------------------------------------

module nutcatch_sidecut(

	name   = "M3",  // name of screw family (i.e. M3, M4, ...) 
	l      = 50.0,  // length of slot
	clk    =  0.0,  // key width clearance
	clh    =  0.0,  // height clearance
	clsl   =  0.1)  // slot width clearance
{ // -----------------------------------------------

	df = _get_fam(name);
	nutkey = df[_NB_F_NUT_KEY];
	nutheight = df[_NB_F_NUT_HEIGHT];
	
	cl = l - _calc_HexInscToSubscRadius(nutkey/2);
	union() {
		translate([l/2, 0, -(nutheight+clh)/2])
			cube([l, nutkey+clk, nutheight+clh], center=true);
		translate([0,0, -(nutheight+clh)/2]) hexaprism(ri=(nutkey+clk)/2, h=nutheight+clh);
	}
}
// -- end of nutcatch_sidecut module
// -----------------------------



// =============================
// -- screw                   --
// -----------------------------
// default is not modelling the thread (for the small screws there is not real use
// to model them)
// Beware that for a diameter only certain screw lengths do actually exist!

module screw(
	name   = "M5x20",  // name of screw (i.e. M3x12, M4x25, ...)
	thread =    "no")  // option wheter or not to model the thread
                          	//   -> no:      bolt has has outer thread diameter (default)
			   				//   -> modeled: actual thread in model
{ // -----------------------------------------------

	ds = _get_screw(name);
	df = _get_screw_fam(name);
	length      = ds[_NB_S_LENGTH];
	nlength		= ds[_NB_S_NOTHREAD_LENGTH];
	tlength     = length-nlength;
	lead		    = df[_NB_F_LEAD];
	orad        = df[_NB_F_OUTER_DIA]/2;
	head_height = df[_NB_F_HEAD_HEIGHT];
	head_rad    = df[_NB_F_HEAD_DIA]/2;

	key_width = df[_NB_F_KEY];
	key_depth = df[_NB_F_KEY_DEPTH];

	if (thread=="modeled") {
		if(nlength>0) {  // if part of the bolt has no thread
			translate([0,0,-nlength/2+lead/2]) cylinder(r = orad, h = nlength-lead, center=true);
			translate([0,0,-nlength+lead/2]) cylinder(r2=orad, r1=orad-lead, h=lead, center=true);
			translate([0,0,-nlength-tlength+lead/2]) thread(orad, tlength+lead, lead);

		} else { // all of the bolt is threaded
			translate([0,0,-tlength]) thread(orad, tlength, lead);
	  	}

	} else { // thread is not modeled
		translate([0,0,-length/2]) cylinder(r = orad, h = length, center=true);
	}

	difference() {
		translate([0,0,head_height/2]) cylinder(r2=head_rad, r1=orad, h=head_height, center=true);
		translate([0,0,head_height]) key_slot(k=key_width, l=key_depth);
	}

}
// -- end of screw module
// -----------------------------



// =============================
// -- nut                     --
// -----------------------------

module nut(

	name =    "M3",  // name of screw (i.e. M3x12, M4x25, ...)
	thread =  "no")  // option wheter or not to model the thread
                         //   -> no:      nut has has inner thread diameter (default)
			 //   -> modeled: actual thread in model
{ // -----------------------------------------------

	df = _get_fam(name);
	nutkey = df[_NB_F_NUT_KEY];
	nutheight = df[_NB_F_NUT_HEIGHT];
	orad = df[_NB_F_OUTER_DIA]/2;
	lead = df[_NB_F_LEAD];
	irad = orad-lead;

	e = _calc_HexInscToSubscRadius(nutkey/2);
	translate([0,0,-nutheight/2]) {
		difference() {
			hexaprism(ri=nutkey/2, h=nutheight);
			cylinder(r=irad, h=nutheight+0.1, center=true);
			if (thread=="modeled") {
				translate([0,0,-nutheight/2]) thread(orad, nutheight, lead);
				translate([0,0,-nutheight/2]) cylinder(r1=orad, r2=irad, h=lead, center=true);
				translate([0,0,nutheight/2]) cylinder(r2=orad, r1=irad, h=lead, center=true);
			}
		}
	}
}
// -- end of nut module
// -----------------------------



// =============================
// -- allen key_slot          --
// -----------------------------

module key_slot(
// if name is given (i.e. key("M5")) the measures will be looked up
// in the database, otherwise key and depth have to be set to the
// key width and the depth of the keyhole in the screw head

	name =   "none",  // name of screw family (i.e. M3, M4, ...)
	k    =      5.0,  // key slot width, used if no name is given
	l    =	    2.0,  // length/depth of key slot, used if no name is given
	clk  =      0.0,  // clearance for key 
	cll  =      0.0)  // clearance for length/depth
{ // -----------------------------------------------

	if (name!="none")
		assign(df = _get_fam(name), 
		       k = df[_NB_F_KEY],
		       l = df[_NB_F_KEY_DEPTH]);
	
	translate([0,0,-(l+cll)/2]) hexaprism(ri=(k+clk)/2, h=(l+cll));
}
// -- end of key_slot module
// -----------------------------



// =============================
// -- thread module           -- 
// -----------------------------

module thread(
// the thread is extruded with a twisted linear extrusion 

	orad,  // outer diameter of thread 
	tl,    // thread length
	p)     // lead of thread
{ // -----------------------------------------------

// radius' for the spiral
r = [orad-0/18*p, orad-1/18*p, orad-2/18*p, orad-3/18*p, orad-4/18*p, orad-5/18*p,
     orad-6/18*p, orad-7/18*p, orad-8/18*p, orad-9/18*p, orad-10/18*p, orad-11/18*p,
     orad-12/18*p, orad-13/18*p, orad-14/18*p, orad-15/18*p, orad-16/18*p, orad-17/18*p,
     orad-p];

// extrude 2d shape with twist
translate([0,0,tl/2])
//difference() {
linear_extrude(height = tl, convexity = 10, twist = -360.0*tl/p, center = true)
	// mirrored spiral (2d poly) -> triangular thread when extruded
	polygon([[ r[ 0]*cos(  0), r[ 0]*sin(  0)], [r[ 1]*cos( 10), r[ 1]*sin( 10)],
		 [ r[ 2]*cos( 20), r[ 2]*sin( 20)], [r[ 3]*cos( 30), r[ 3]*sin( 30)],
		 [ r[ 4]*cos( 40), r[ 4]*sin( 40)], [r[ 5]*cos( 50), r[ 5]*sin( 50)],
	     	 [ r[ 6]*cos( 60), r[ 6]*sin( 60)], [r[ 7]*cos( 70), r[ 7]*sin( 70)],
		 [ r[ 8]*cos( 80), r[ 8]*sin( 80)], [r[ 9]*cos( 90), r[ 9]*sin( 90)],
		 [ r[10]*cos(100), r[10]*sin(100)], [r[11]*cos(110), r[11]*sin(110)],
		 [ r[12]*cos(120), r[12]*sin(120)], [r[13]*cos(130), r[13]*sin(130)],
		 [ r[14]*cos(140), r[14]*sin(140)], [r[15]*cos(150), r[15]*sin(150)],
		 [ r[16]*cos(160), r[16]*sin(160)], [r[17]*cos(170), r[17]*sin(170)],
		 [ r[18]*cos(180), r[18]*sin(180)], [r[17]*cos(190), r[17]*sin(190)],
		 [ r[16]*cos(200), r[16]*sin(200)], [r[15]*cos(210), r[15]*sin(210)],
		 [ r[14]*cos(220), r[14]*sin(220)], [r[13]*cos(230), r[13]*sin(230)],
		 [ r[12]*cos(240), r[12]*sin(240)], [r[11]*cos(250), r[11]*sin(250)],
		 [ r[10]*cos(260), r[10]*sin(260)], [r[ 9]*cos(270), r[ 9]*sin(270)],
		 [ r[ 8]*cos(280), r[ 8]*sin(280)], [r[ 7]*cos(290), r[ 7]*sin(290)],
		 [ r[ 6]*cos(300), r[ 6]*sin(300)], [r[ 5]*cos(310), r[ 5]*sin(310)],
		 [ r[ 4]*cos(320), r[ 4]*sin(320)], [r[ 3]*cos(330), r[ 3]*sin(330)],
		 [ r[ 2]*cos(340), r[ 2]*sin(340)], [r[ 1]*cos(350), r[ 1]*sin(350)]
                ]);
}
// -----------------------------



// ===========================================
// -- 2d shape: hexagon by inscribed circle --
// -------------------------------------------

module hexagon(
// the radius of inscribed circle corresponds to the
// half of the key width

	ri =  1.0)   // inner radius of hexagon
{ // -----------------------------------------------

	ra = ri*2/sqrt(3);
	circle(r = ra, $fn=6, center=true);
}
// -- end of hexagon
// -----------------------------



// ==========================================
// -- 3d shape: hexaprism by inscr. circle --
// ------------------------------------------

module hexaprism(

	ri =  1.0,  // radius of inscribed circle
	h  =  1.0)  // height of hexaprism
{ // -----------------------------------------------

	ra = ri*2/sqrt(3);
	cylinder(r = ra, h=h, $fn=6, center=true);
}
// -- end of hexaprism
// -----------------------------



// ===========================
// helper functions

// calculate the subscribing radius from the inscribing radius
// for a hexagon
// key width (i.e. allen keys) correspont to the inner radius
// but we draw the hexagon using the outer radius
function _calc_HexInscToSubscRadius(ri) = ri*2/sqrt(3);