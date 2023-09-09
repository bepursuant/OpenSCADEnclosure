use <RoundedCube.scad>



module FlatBox(length, width, height, thickness, radius, overlap, slop, half="top"){

	$fn = 32;			//segments for radius

	hide = 0.01;		//for reasons, just trust me

	//overall outside dimensions of the finished box (closed, both halves)
	boxL = length;
	boxW = width;
	boxH = height;

	//additional build parameters
	//radius 		= radius;		//mm on Z axis corners
	//thickness 	= thickness;	//mm wall thickness as [x,y,z]
	//overlap 	= overlap;		//mm of overlap between top and bottom halves
	//half		= half;			//which half to render

	//******************************************
	//shell shape
	shellThickness = thickness;
	shellRadius = radius;

	shellL = boxL;
	shellW = boxW;
	shellH = (boxH-overlap)/2;

	shellX = 0;
	shellY = 0;
	shellZ = 0;

	module _shell(length, width, height, thickness, radius){

		//the cavity inside the box
		shellCavityRadius = radius - ((thickness[0]+thickness[1])/2);

		shellCavityL = length - (2*thickness[0]);
		shellCavityW = width - (2*thickness[1]);
		shellCavityH = height - thickness[2];

		shellCavityX = thickness[0];
		shellCavityY = thickness[1];
		shellCavityZ = thickness[2];

		difference(){
			//shell shape
			roundedCubeZ([length, width, height], radius=radius);

			//shell cavity
			translate([shellCavityX, shellCavityY, shellCavityZ])
				roundedCubeZ([shellCavityL, shellCavityW, shellCavityH], radius=shellCavityRadius);
		}
	}

	module shell(){
		translate([shellX, shellY, shellZ])
			_shell(shellL, shellW, shellH, thickness, shellRadius);
	}

	module _flange(length, width, height, thickness, radius){

		//flange cavity
		flangeCavityRadius = radius - ((thickness[0]+thickness[1])/2);

		flangeCavityL = length - (2*thickness[0]);
		flangeCavityW = width - (2*thickness[1]);
		flangeCavityH = height;

		flangeCavityX = thickness[0];
		flangeCavityY = thickness[1];

		difference(){
			//flange shape
			roundedCubeZ([length, width, height], radius);

			//flange cavity
			translate([flangeCavityX, flangeCavityY])
				roundedCubeZ([flangeCavityL, flangeCavityW, flangeCavityH], radius=flangeCavityRadius);
		}
	}

	module flange(){

		flangeThickness = [(thickness[0]-slop)/2, (thickness[1]-slop)/2];

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
			flangeRadius = shellRadius - ((flangeThickness[0]+flangeThickness[1])/2) - slop;

			flangeL = shellL - (2*flangeThickness[0]) - (2*slop);
			flangeW = shellW - (2*flangeThickness[1]) - (2*slop);
			flangeH = overlap;

			flangeX = shellX + flangeThickness[0] + (slop);
			flangeY = shellY + flangeThickness[1] + (slop);
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

//FlatBox(10, 10, 10, [1,1,1] , 2, 1, 0.1, "top");