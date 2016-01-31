module rightTriangle(l, w, h){
	linear_extrude(height = l)
		polygon([[h, 0], [0, 0], [0, w]]);
}

