/// @description
if keyboard_check_pressed(vk_f5){
	instance_destroy();
	instance_create_depth(0, 0, 0, o_main);
}

shineFrame++;

hoveredCell = -1;
hoveredCells = array_create(7, -1);
acceptableCells = array_create(7, false);
var _hoveredReactionOld = hoveredReaction;
hoveredReaction = -1;
if mouse_check_button_pressed(mb_right){
	selectedReaction = -1;
}
if keyboard_check_pressed(ord("1")){
	selectedReaction = 0;
}else if keyboard_check_pressed(ord("2")){
	selectedReaction = 1;
}else if keyboard_check_pressed(ord("3")){
	selectedReaction = 2;
}
if mouse_x <= 39 or mouse_x >= 156{
	if mouse_x >= 156{
		if mouse_y > 92.5{
			hoveredReaction = 2;
		}else if 50.5 < mouse_y{
			hoveredReaction = 1;
		}else if mouse_y >= 8{
			hoveredReaction = 0;
		}
	}
	if hoveredReaction != _hoveredReactionOld and hoveredReaction >= 0 and selectedReaction == -1{
		shineFrame = 0;
	}
	if mouse_check_button_pressed(mb_left){
		selectedReaction = hoveredReaction;
	}
	exit;
}


if selectedReaction != -1{
	// Voronoi selection is possibly the slowest way to do this.  Whatever
	var _mouseXOffset = mouse_x - 5.5 - global.REACTION_SELECTION_OFFSETS_X[reactionType[selectedReaction]];
	var _mouseYOffset = mouse_y - 5.5 - global.REACTION_SELECTION_OFFSETS_Y[reactionType[selectedReaction]];
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
	
	///
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
	
	var _acceptable = true;
	var _reactant = reactants[selectedReaction];
	var _shouldChange = array_create(7, false);
	for (var _cell = 0; _cell < 7; _cell++){
		var _reactantElement = _reactant[_cell];
		if _reactantElement == -1{
			acceptableCells[_cell] = true;
			continue;
		}
			
		var _hoveredCell = hoveredCells[_cell];
		if _hoveredCell == -1{
			acceptableCells[_cell] = false;
			_acceptable = false;
			continue;
		}
			
		var _hoveredElement = hexes[_hoveredCell];
			acceptableCells[_cell] = does_match(_hoveredElement, _reactantElement);
		_shouldChange[_cell] = true;
		if not acceptableCells[_cell]{
			_acceptable = false;
		}
	}
		
	if _acceptable and mouse_check_button_pressed(mb_left){
		var _product = products[selectedReaction];
		for (var _cell = 0; _cell < 7; _cell++){
			if _shouldChange[_cell]{
				var _hoveredCell = hoveredCells[_cell];
				var _productElement = _product[_cell];
				hexes[_hoveredCell] = _productElement;
			}
		}
			
		/// New reaction
		reaction_update(selectedReaction);
			
		if reactionGrabBagIndex == array_length(reactionGrabBagElementCount){
			reaction_grab_bag_shuffle();
		}
			
		scan_for_matches();
			
		selectedReaction = -1;
	}
}