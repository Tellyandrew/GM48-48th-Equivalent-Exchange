/// @description
if keyboard_check_pressed(vk_f5){
	instance_destroy();
	instance_create_depth(0, 0, 0, o_main);
}

global.currentFrame++;

hoveredCell = -1;
selectedReaction = -1;
if mouse_x >= 156{
	if mouse_y > 92.5{
		selectedReaction = 2;
	}else if 50.5 < mouse_y{
		selectedReaction = 1;
	}else if mouse_y >= 8{
		selectedReaction = 0;
	}
	exit;
}


// Voronoi selection is possibly the slowest way to do this.  Whatever
var _mouseXOffset = mouse_x - 5.5;
var _mouseYOffset = mouse_y - 5.5;
var _closestDistance = 100000000;
for (var _cell = 0; _cell < sqr(11); _cell++){
	var _element = hexes[_cell];
	if _element == -1{
		continue;
	}
	
	var _xPos = hexesXPos[_cell];
	var _yPos = hexesYPos[_cell];
	
	var _distance = point_distance(_mouseXOffset, _mouseYOffset, _xPos, _yPos);
	if _distance < _closestDistance{
		_closestDistance = _distance;
		hoveredCell = _cell;
	}
}

hoveredCells = array_create(7, -1);
if hoveredCell != -1{
	var _iPos = hoveredCell % 11;
	var _jPos = floor(hoveredCell/11);
	
	hoveredCells[3] = hoveredCell;
	
	var _upCell = _iPos + (_jPos - 1)*11;
	if _jPos - 1 >= 0 and hexes[_upCell] != -1{
		hoveredCells[2] = _upCell;
	}
	var _downCell = _iPos + (_jPos + 1)*11;
	if _jPos + 1 < 11 and hexes[_downCell] != -1{
		hoveredCells[4] = _downCell;
	}
	
	var _oddEven = 1 - (_iPos & 0b1);
	if _iPos - 1 >= 0{
		var _upLeftCell = _iPos - 1 + (_jPos - 1 + _oddEven)*11;
		if _jPos - 1 + _oddEven >= 0 and hexes[_upLeftCell] != -1{
			hoveredCells[0] = _upLeftCell;
		}
		var _downLeftCell = _iPos - 1 + (_jPos + _oddEven)*11;
		if _jPos + _oddEven < 11 and hexes[_downLeftCell] != -1{
			hoveredCells[1] = _downLeftCell;
		}
	}
	if _iPos + 1 < 11{
		var _upRightCell = _iPos + 1 + (_jPos - 1 + _oddEven)*11;
		if _jPos - 1 + _oddEven >= 0 and hexes[_upRightCell] != -1{
			hoveredCells[5] = _upRightCell;
		}
		var _downRightCell = _iPos + 1 + (_jPos + _oddEven)*11;
		if _jPos + _oddEven < 11 and hexes[_downRightCell] != -1{
			hoveredCells[6] = _downRightCell;
		}
	}
}