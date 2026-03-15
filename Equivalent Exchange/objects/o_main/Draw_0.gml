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
	
	var _xPos = 157;
	_yPos -= 3;
	draw_sprite(s_ticker, fragmentsPrimed[i], _xPos, _yPos);
}

draw_sprite(s_alchemy, fragmentIndex, 0, 0);

if playerWon{
	draw_sprite(s_hudWin, 0, 0, 0);
	draw_set_halign(fa_center);
	
	draw_text_colour(198, 2, "YOU WIN", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	
	var _yPos = 11;
	var _spacer = 23;
	
	draw_text_colour(198, _yPos, "TOTAL REACTIONS\n" + string(reactionTotal), #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	draw_text_colour(198, _yPos + 0 + _spacer*1 - 6, "HIGHEST RECORDED\nTOTAL REACTIONS\n" + string(global.highest), #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	draw_text_colour(198, _yPos + 0 + _spacer*2 - 6, "LOWEST RECORDED\nTOTAL REACTIONS\n" + string(global.lowest), #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	draw_text_colour(198, _yPos + _spacer*3 - 6, "RECORDED SCORES ARE\nNOT SAVED BETWEEN\nPLAY SESSIONS", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	draw_text_colour(198, _yPos + _spacer*4 - 6, "PLAY AGAIN AND TRY\nTO BEAT YOUR HIGHEST\nOR LOWEST SCORE", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	draw_text_colour(198, _yPos + _spacer*5 - 6 + 1, "PRESS 'SPACE' TO\nPLAY AGAIN", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
}

if playerLost{
	draw_sprite(s_hudLose, 0, 0, 0);
	draw_set_halign(fa_center);
	
	draw_text_colour(19.5, 2, "YOU LOSE", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	
	var _yPos = 11;
	
	draw_text_colour(19.5, 11, "THERE\nARE NO\nLONGER\nANY\nGROUPS\nOF\nELEMENTS\nTHAT CAN\nCREATE A\nREACTION", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	draw_text_colour(19.5, 81, $"FRAGMENT\nTOTAL\n{string(fragmentTotal)}/37", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	draw_text_colour(19.5, 109, "PRESS\n'SPACE'\nTO TRY\nAGAIN", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
}

draw_set_halign(fa_left);
draw_text_colour(text1XOffset, hexesYOffset, "FRAGMENTS", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
draw_text_colour(text1XOffset, hexesYOffset + 6, (fragmentTotal < 10 ? "0" : "") + string(fragmentTotal) + "/37", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);

draw_set_halign(fa_right);
draw_text_colour(text2XOffset, hexesYOffset, "REACTIONS", #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
draw_text_colour(text2XOffset, hexesYOffset + 6, string(reactionTotal), #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);

if global.tutorial{
	draw_sprite(s_hudTutorial, 0, 0, 0);
	
	draw_set_halign(fa_center);
	
	var _text = "";
	switch(global.tutorialIndex){
		case 0:
			_text = "WELCOME TO\nPHILOSOPHER'S FRAGMENTS\n\nYOUR GOAL IS TO SYNTHESIZE\nTHE PHILOSOPHER'S STONE\n\nSTART BY SELECTING THE THIRD\nREACTION ON THE RIGHT THEN\nCLICK ON THE GRID BELOW";
			break;
		case 1:
			_text = "YOU JUST TRANSMUTED 7 FIRE\nELEMENTS INTO AIR ELEMENTS\n\nNOW USE THE FIRST REACTION\nON THE RIGHT AND MATCH IT\nTO THE AIR ELEMENTS THAT\nYOU JUST TRANSMUTED IN\nORDER TO TURN THEM FROM AIR\nINTO WATER AND `THER";
			break;
		case 2:
			_text = "NOW NOTHING ON THE BOARD\nMATCHES DIRECTLY WITH\nYOUR REACTANTS\n\nTHANKFULLY `THER AND ONLY\n`THER WILL MATCH WITH\nANYTHING\n\nHINT `THER IS PURPLE";
			break;
		case 3:
			_text = "AFTER YOU USE AT LEAST ONE\nREACTION ON ALL 3 ROWS THE\nNEXT REACTION WILL HAVE\n`THER AS THE REACTANT AND A\nRED PHILOSOPHER'S FRAGMENT\nAS THE PRODUCT\n\nPLACE AS MANY FRAGMENTS AS\nPOSSIBLE IN ORDER TO WIN";
			break;
		case 4:
			_text = "UNFORTUNATELY YOU RAN OUT\nOF MOVES AND LOST AS\nEXPLAINED ON THE LEFT\n\nWHEN YOU RESTART THE GAME\nBY PRESSING 'SPACE' IT WILL\nNO LONGER BE THE TUTORIAL\n\nGOOD LUCK";
			break;
	}
	draw_text_colour(97.5, 2, _text, #FFDC91, #FFDC91, #FFDC91, #FFDC91, 1);
	//97.5
}