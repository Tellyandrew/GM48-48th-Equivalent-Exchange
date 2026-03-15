/// @description

global.currentFrame = -1;


hoveredCell = -1;

selectedReaction = -1;





///
hexesXOffset = 42;
hexesYOffset = 2;

hexes = array_create(sqr(11), -1);
hexesXPos = array_create(sqr(11));
hexesYPos = array_create(sqr(11));

for (var i = 0; i < 11; i++){
	for (var j = 0; j < 11; j++){
		if i + j*2 < 4{
			continue;
		}
		if 10 - i + j*2 < 4{
			continue;
		}
		if i - 1 + (10 - j)*2 < 4{
			continue;
		}
		if (9 - i) + (10 - j)*2 < 4{
			continue;
		}
		
		var _xPos = hexesXOffset + i*10;
		var _yPos = hexesYOffset + j*12 + (i & 0b1 ? 0 : 6);
		
		var _cell = i + j*11;
		hexesXPos[_cell] = _xPos;
		hexesYPos[_cell] = _yPos;
		hexes[_cell] = s_water;//global.elements[irandom(global.elementNumber - 1)];
	}
}

hexes[5 + 5*11] = s_shard;

///
reactantsXOffset = 160;
productsXOffset = 205;
var _yOffsetGap = 42;
reactionYOffsets = array_create(3);
reactants = array_create(3);
products = array_create(3);

for (var i = 0; i < 3; i++){
	reactionYOffsets[i] = 12 + _yOffsetGap*i;
	reactants[i] = array_create(7, -1);
	products[i] = array_create(7, -1);
	for (var _cell = 0; _cell < 7; _cell++){
		
		reactants[i][_cell] = global.elements[i];
		products[i][_cell] = global.elements[i + 2];
	}
}

reactionXPos = array_create(7);
reactionYPos = array_create(7);

var _xPos = 0;
reactionXPos[0] = _xPos;
reactionYPos[0] = 6;
reactionXPos[1] = _xPos;
reactionYPos[1] = 6 + 12;
_xPos += 10;
reactionXPos[2] = _xPos;
reactionYPos[2] = 0;
reactionXPos[3] = _xPos;
reactionYPos[3] = 12;
reactionXPos[4] = _xPos;
reactionYPos[4] = 24;
_xPos += 10;
reactionXPos[5] = _xPos;
reactionYPos[5] = 6;
reactionXPos[6] = _xPos;
reactionYPos[6] = 6 + 12;

hoveredCells = array_create(7);