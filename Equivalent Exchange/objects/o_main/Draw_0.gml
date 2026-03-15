/// @description
for (var _cell = 0; _cell < sqr(11); _cell++){
	var _element = hexes[_cell];
	if _element == -1{
		continue;
	}
		
	draw_sprite(hexes[_cell], 0, hexesXPos[_cell], hexesYPos[_cell]);
}

if hoveredCell != -1 and selectedReaction != -1{
	for (var _index = 0; _index < 7; _index++){
		var _cell = hoveredCells[_index];
		if _cell == -1{
			continue;
		}
		
		if not acceptableCells[_index]{
			draw_sprite(s_cant, 0, hexesXPos[_cell], hexesYPos[_cell]);
		}
	}
	
	draw_sprite(s_selectionator, reactionType[selectedReaction], hexesXPos[hoveredCell], hexesYPos[hoveredCell]);
}

var _frame = (shineFrame / 2) % 45;
if _frame < sprite_get_number(s_shine){
	var _mask = 0b0;
	if selectedReaction != -1{
		_mask |= 0b1 << selectedReaction;
	}
	if hoveredReaction != -1{
		_mask |= 0b1 << hoveredReaction;
	}
	for (var _cell = 0; _cell < sqr(11); _cell++){
		if matches[_cell] & _mask{
			var _colour = hexes[_cell] == s_aether ? #F3C3D8 : c_white;
			draw_sprite_ext(s_shine, _frame, hexesXPos[_cell], hexesYPos[_cell], 1, 1, 0, _colour, 1);
		}
	}
}

draw_sprite(s_hud, 0, 0, 0);

if hoveredReaction != -1{
	draw_sprite(s_selector, hoveredReaction, 0, 0);
}
if selectedReaction != -1{
	draw_sprite(s_selection, selectedReaction, 0, 0);
	var _yPos = reactionYOffsets[selectedReaction] + 12;
	draw_sprite(s_selectionator, reactionType[selectedReaction], reactantsXOffset + 10, _yPos);
	draw_sprite(s_selectionator, reactionType[selectedReaction], productsXOffset + 10, _yPos);
}

for (var i = 0; i < 3; i++){
	var _yPos = reactionYOffsets[i];
	for (var _cell = 0; _cell < 7; _cell++){
		var _sprite = reactants[i][_cell];
		if _sprite != -1{
			draw_sprite(_sprite, 0, reactantsXOffset + reactionXPos[_cell], _yPos + reactionYPos[_cell]);
		}
		
		var _sprite = products[i][_cell];
		if _sprite != -1{
			draw_sprite(_sprite, 0, productsXOffset + reactionXPos[_cell], _yPos + reactionYPos[_cell]);
		}
	}
}