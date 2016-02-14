use <RoundedCube.scad>

$fn = 36;			//segments for radius

slop = 0.3;			//spacing between moving sections

hide = 0.01;		//hide simply makes difference()d walls not show during preview

lipH = 8;


//main body shape
bodyRadius = 0;
bodyWall = 2;
bodyL = 60;
bodyW = 60;
bodyH = 20 - lipH;
bodyX = 0;
bodyY = 0;
bodyZ = 0;

//body lip shape
bodyLipRadius = bodyRadius - bodyWall;
bodyLipWall = 0.8;
bodyLipL = bodyL - (2*bodyWall);
bodyLipW = bodyW - (2*bodyWall);
bodyLipH = bodyH + lipH;
bodyLipX = bodyX + bodyWall;
bodyLipY = bodyY + bodyWall;
bodyLipZ = bodyZ;

//body inside cavity
bodyCavitySpacing = slop;
bodyCavityRadius = bodyLipRadius - bodyLipWall;
bodyCavityL = bodyLipL - (2*bodyLipWall);
bodyCavityW = bodyLipW - (2*bodyLipWall);
bodyCavityH = bodyLipH - bodyLipWall + hide;
bodyCavityX = bodyLipX + bodyLipWall;
bodyCavityY = bodyLipY + bodyLipWall;
bodyCavityZ = bodyLipZ + bodyLipWall;



//cover shape;
coverRadius = bodyRadius;
coverWall = bodyWall;
coverL = bodyL;
coverW = bodyW;
coverH = lipH + coverWall;
coverX = bodyX;
coverY = bodyY;
coverZ = bodyH;






module body(){
	difference(){

		union(){
			//main body shape
			translate([bodyX, bodyY, bodyZ])
				roundedCubeZ([bodyL, bodyW, bodyH], bodyRadius);


			translate([bodyLipX, bodyLipY, bodyLipZ])
				roundedCubeZ([bodyLipL, bodyLipW, bodyLipH], bodyLipRadius);
		}

		//main cavity shape
		translate([bodyCavityX, bodyCavityY, bodyCavityZ])
			roundedCubeZ([bodyCavityL, bodyCavityW, bodyCavityH], radius=bodyCavityRadius);

	}
}

module cover(){

	difference(){
		translate([coverX, coverY, coverZ])
			roundedCubeZ([coverL, coverW, coverH], coverRadius);

		translate([bodyLipX, bodyLipY, bodyLipZ])
			roundedCubeZ([bodyLipL, bodyLipW, bodyLipH], bodyLipRadius);
	}

}





difference(){
	union(){
		body();
		//cover();
	}

	//horizontal cut
	translate([0,0,bodyH/2]){	//TOP
		//cube([bodyL, bodyW, bodyH/2]);
	}
	translate([bodyL/4,0,0]){ //FRONT
		//cube([bodyL, bodyW, bodyLipH + 5]);
	}

	//vertical cut
	translate([0,bodyW/2,0]){
		//cube([bodyL + 5, bodyW, bodyH]);
	}
}