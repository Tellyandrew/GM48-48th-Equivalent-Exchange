/// @description
shineFrame = -1;

hoveredCell = -1;

hoveredReaction = -1;
selectedReaction = -1;

hoveredCells = array_create(7);
acceptableCells = array_create(7, false);

///

// Reaction types
// 7 of 1
// 3.5 of 2
// 2.33 of 3
// 1.75 of 4
// 1 of 7

grabBagModulator = array_create(ELEMENT_COUNT.NUMBER);
grabBagModulator[ELEMENT_COUNT.ONE] = 7;
grabBagModulator[ELEMENT_COUNT.TWO] = 4;
grabBagModulator[ELEMENT_COUNT.THREE] = 3;
grabBagModulator[ELEMENT_COUNT.FOUR] = 1;
grabBagModulator[ELEMENT_COUNT.SEVEN] = 1;

reaction_grab_bag_shuffle();

fragmentsPrimed = array_create(3, 0);
fragmentIndex = 0;
var _twoRandom = array_shuffle([REACTION_TYPE.TWO_NORTH, REACTION_TYPE.TWO_EAST, REACTION_TYPE.TWO_WEST]);
var _threeRandom = array_shuffle([REACTION_TYPE.THREE_EAST, REACTION_TYPE.THREE_WEST]);
var _fourRandom = array_shuffle([
	choose(REACTION_TYPE.FOUR_GLOB_NORTH, REACTION_TYPE.FOUR_GLOB_EAST, REACTION_TYPE.FOUR_GLOB_WEST),
	choose(REACTION_TYPE.FOUR_T_NORTH, REACTION_TYPE.FOUR_T_SOUTH)
]);
fragmentIndex = 0;
fragmentShapes = [
	REACTION_TYPE.ONE, _twoRandom[0], REACTION_TYPE.ONE, _twoRandom[1], REACTION_TYPE.ONE, _twoRandom[2],
	REACTION_TYPE.ONE, _threeRandom[0], REACTION_TYPE.ONE, _threeRandom[1],
	REACTION_TYPE.ONE, _fourRandom[0], REACTION_TYPE.ONE, _fourRandom[1],
	REACTION_TYPE.ONE, REACTION_TYPE.SEVEN, REACTION_TYPE.ONE
];
playerWon = false;
playerLost = false;

///
hexesXOffset = 42;
hexesYOffset = 2;
text1XOffset = 41;
text2XOffset = 155;

reactionTotal = 0;
fragmentTotal = 1;

hexes = array_create(sqr(11), -1);
matches = array_create(sqr(11), 0b0);
hexesXPos = array_create(sqr(11));
hexesYPos = array_create(sqr(11));

//I don't feel like figuring out if there's statistical bias towards one side of the board, so lazy method it is
var _elementSlots = array_create(90);
for (var i = 0; i < 90; i++){
	_elementSlots[i] = global.elements[floor(i/(90/global.elementNumber))];
}
array_shuffle_ext(_elementSlots);
var _elementSlotIndex = 0;

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
		if not global.tutorial{
			if _cell != 5 + 5*11{
				hexes[_cell] = _elementSlots[_elementSlotIndex];
				_elementSlotIndex++;
			}
		}else{
			hexes[_cell] = j > 4 ? s_fire : -1;
		}
	}
}

if not global.tutorial{
	hexes[5 + 5*11] = s_shard;
}

///
reactantsXOffset = 160;
productsXOffset = 205;
var _yOffsetGap = 42;
reactionYOffsets = array_create(3);
reactants = array_create(3);
products = array_create(3);
reactionType = array_create(3, REACTION_TYPE.ONE);

for (var i = 0; i < 3; i++){
	reactionYOffsets[i] = 12 + _yOffsetGap*i;
	
	//
	if not global.tutorial{
		reaction_update(i);
	}
}
if global.tutorial{
	reactionType[2] = REACTION_TYPE.SEVEN;
	reactants[2] = [s_fire, s_fire, s_fire, s_fire, s_fire, s_fire, s_fire];
	products[2] = [s_air, s_air, s_air, s_air, s_air, s_air, s_air];
	reactionType[0] = REACTION_TYPE.FOUR_T_NORTH;
	reactants[0] = [-1, s_air, s_air, s_air, -1, -1, s_air];
	products[0] = [-1, s_aether, s_aether, s_water, -1, -1, s_aether];
	reactionType[1] = REACTION_TYPE.SEVEN;
	reactants[1] = [s_air, s_air, s_air, s_water, s_air, s_air, s_air];
	products[1] = [s_fire, s_fire, s_fire, s_fire, s_fire, s_fire, s_fire];
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

scan_for_matches();