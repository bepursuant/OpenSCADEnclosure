use <RoundedCube.scad>
use <lib/NutsandBolts.scad>

module FlatBox(length, width, height, thickness, radius, overlap, slop, half="top"){

	$fn = 32;			//segments for radius

	hide = 0.01;		//for reasons, just trust me


	//overall outside dimensions of the finished box (closed, both halves)
	boxL = length;
	boxW = width;
	boxH = height;

	//additional build parameters
	radius 		= radius;		//mm on Z axis corners
	thickness 	= thickness;	//mm wall thickness
	overlap 	= overlap;		//mm of overlap between top and bottom halves
	half		= half;			//which half to render

	//******************************************
	//shell shape
	shellThickness = thickness;
	shellRadius = radius;

	shellL = boxL;
	shellW = boxW;
	shellH = (boxH/2) - overlap;

	shellX = 0;
	shellY = 0;
	shellZ = 0;

	module _shell(length, width, height, thickness, radius){

		//the cavity inside the box
		shellCavityRadius = radius - thickness;

		shellCavityL = length - (2*thickness);
		shellCavityW = width - (2*thickness);
		shellCavityH = height;

		shellCavityX = thickness;
		shellCavityY = thickness;
		shellCavityZ = thickness;

		difference(){

			//shell shape
			roundedCubeZ([length, width, height], radius);

			//shell cavity
			translate([shellCavityX, shellCavityY, shellCavityZ])
				roundedCubeZ([shellCavityL, shellCavityW, shellCavityH], radius=shellCavityRadius);

		}
	}

	module shell(){
		translate([shellX, shellY, shellZ])
			_shell(shellL, shellW, shellH, shellThickness, shellRadius);
	}

	module _flange(length, width, height, thickness, radius){

		//flange cavity
		flangeCavityRadius = radius - thickness;

		flangeCavityL = length - (2*thickness);
		flangeCavityW = width - (2*thickness);
		flangeCavityH = height;

		flangeCavityX = thickness;
		flangeCavityY = thickness;

		difference(){
			//flange shape
			roundedCubeZ([length, width, height], radius);

			//flange cavity
			translate([flangeCavityX, flangeCavityY])
				roundedCubeZ([flangeCavityL, flangeCavityW, flangeCavityH], radius=flangeCavityRadius);
		}
	}

	module flange(){
		flangeThickness = (thickness/2)-slop;

		if(half=="top"){
			flangeRadius = shellRadius;

			flangeL = boxL;
			flangeW = boxW;
			flangeH = overlap;

			flangeX = shellX;
			flangeY = shellY;
			flangeZ = shellZ + shellH;

			translate([flangeX, flangeY, flangeZ])
				_flange(flangeL, flangeW, flangeH, flangeThickness, flangeRadius);
		} else {
			flangeRadius = shellRadius - flangeThickness - (2*slop);

			flangeL = shellL - (2*flangeThickness) - (4*slop);
			flangeW = shellW - (2*flangeThickness) - (4*slop);
			flangeH = overlap;

			flangeX = shellX + flangeThickness + (2*slop);
			flangeY = shellY + flangeThickness + (2*slop);
			flangeZ = shellZ + shellH;

			translate([flangeX, flangeY, flangeZ])
				_flange(flangeL, flangeW, flangeH, flangeThickness, flangeRadius);
		}

	}

	difference(){
		union(){
			shell();
			flange();
		}

		//horizontal cut
		translate([0,0,shellH/2]){	//TOP
			//cube([shellL, shellW, shellH]);
		}
		translate([shellL/2,0,0]){ //FRONT
			//cube([shellL, shellW, shellH]);
		}

		//vertical cut
		translate([0,shellW/2,0]){
			//cube([shellL, shellW, shellH]);
		}
	}

}