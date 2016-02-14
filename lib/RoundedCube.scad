// roundedCube.scad - OpenSCAD library to create cubes that are rounded
// to a certain radius along a specified axis. Multiple roundedCubes
// can be unioned to create a compound cube with multiple radius.

// Ceates the shape that needs to be subtracted from a cube to
// round its corners. This essentially creates the metal die
// for a virtual 3D corner punch, which we use with a diff
module createMeniscus(height, radius){
	//Take the difference of...
	difference(){
		// ... a quarter of a cube...
		translate([-0.1, -0.1, -0.1]){
			cube([radius + 0.2, radius + 0.2, height + 0.2]); 
		}
		// ... and a cylinder.
		translate([0.1,0.1]){
			cylinder(h = height, r = radius, $fn = 25);
		}
	}
}

// This module creates a cube and subtracts the corners defined
// by cylinders of the specified radius. The rounded corners
// are made in the Z axis rotated around an axis if needed
module _roundedCube(x, y, z, r) {

	difference(){
		translate(){
			cube([x, y, z]);
		}

		translate([x - r, 0 + r, 0]){
			rotate(270){
				createMeniscus(z, r);
			}
		}

		translate([0 + r, 0 + r, 0]){
			rotate(180){  
				createMeniscus(z, r); 
			}
		}
		
		translate([0 + r, y - r, 0]){
			rotate(90){
				createMeniscus(z, r);
			}
		}

		translate([x - r, y - r, 0]){
			rotate(0){
				createMeniscus(z, r);
			}
		}


	}
}

module roundedCubeZ(size, radius){
	rotate(0){
		_roundedCube(size[0], size[1], size[2], radius);
	}
}

module roundedCubeX(size, radius){
	rotate([90,0,90]){
		_roundedCube(size[1], size[2], size[0], radius);
	}
}

module roundedCubeY(size, radius){
	translate([0,size[1],size[2]]){
		rotate([90,90,0]){
			_roundedCube(size[2], size[0], size[1], radius);
		}
	}
}

//roundedCubeZ(size=[10, 20, 30], radius=2);
//createMeniscus(height=150, radius=5);