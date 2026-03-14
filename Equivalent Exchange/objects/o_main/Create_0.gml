/// @description
hexesXOffset = 43;
hexesYOffset = 2;

hexes = array_create(sqr(11), undefined);
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
		hexes[_cell] = true;
		
		instance_create_depth(_xPos, _yPos, -99100, o_mask, {cell : _cell});
	}
}