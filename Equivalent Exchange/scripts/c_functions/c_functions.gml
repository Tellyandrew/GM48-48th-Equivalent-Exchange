function reaction_update(_index){
	var _tryAgain;
	do{
		_tryAgain = false;
		var _elementCount = reactionGrabBagElementCount[reactionGrabBagIndex];
		var _reactionShapes = global.REACTION_SHAPES[_elementCount];
		reactionType[_index] = _reactionShapes[irandom(array_length(_reactionShapes) - 1)];
		var _reactionTemplates = global.REACTION_TEMPLATES[reactionType[_index]];
		var _reactionTemplateNumber = array_length(_reactionTemplates);
		var _reactionTemplateA = _reactionTemplates[irandom(_reactionTemplateNumber - 1)];
		var _reactionTemplateB = _reactionTemplates[irandom(_reactionTemplateNumber - 1)];
		var _reactionTemplateBStartIndex = _reactionTemplateA[3] + 1;
		var _reactionElements = array_shuffle(global.elements);
		reactants[_index] = array_create(7, -1);
		products[_index] = array_create(7, -1);
		for (var _cell = 0; _cell < 7; _cell++){
			if _reactionTemplateA[_cell] == -1{
				continue;
			}
			
			var _element = _reactionElements[_reactionTemplateA[_cell] % global.elementNumber];
			if _element == s_aether{
				_tryAgain = true;
				break;
			}
		
			reactants[_index][_cell] = _element;
			products[_index][_cell] = _reactionElements[(_reactionTemplateB[_cell] + _reactionTemplateBStartIndex) % global.elementNumber];
		}
	}until not _tryAgain;
	
	reactionGrabBagIndex++;
}

function reaction_update_alt2(_index){
	reactants[_index] = array_create(7, -1);
	products[_index] = array_create(7, -1);
	
	var _elementCount = reactionGrabBagElementCount[reactionGrabBagIndex];
	var _reactionShapes = global.REACTION_SHAPES[_elementCount];
	reactionType[_index] = _reactionShapes[irandom(array_length(_reactionShapes) - 1)];
	var _reactionTemplates = global.REACTION_TEMPLATES[reactionType[_index]];
	var _reactionTemplateNumber = array_length(_reactionTemplates);
	var _reactionTemplateA = _reactionTemplates[irandom(_reactionTemplateNumber - 1)];
	var _reactionTemplateB = _reactionTemplates[irandom(_reactionTemplateNumber - 1)];
	var _reactionTemplateBStartIndex = _reactionTemplateA[3] + 1;
	var _reactionElements = array_shuffle(global.elements);
	for (var _cell = 0; _cell < 7; _cell++){
		if _reactionTemplateA[_cell] == -1{
			continue;
		}
		
		reactants[_index][_cell] = _reactionElements[_reactionTemplateA[_cell] % global.elementNumber];
		products[_index][_cell] = _reactionElements[(_reactionTemplateB[_cell] + _reactionTemplateBStartIndex) % global.elementNumber];
	}
	
	reactionGrabBagIndex++;
}

function reaction_update_alt(_index){
	var _elementCount = reactionGrabBagElementCount[reactionGrabBagIndex];
	var _reactionShapes = global.REACTION_SHAPES[_elementCount];
	reactionType[_index] = _reactionShapes[irandom(array_length(_reactionShapes) - 1)];
	var _reactionTemplates = global.REACTION_TEMPLATES[reactionType[_index]];
	var _reactionTemplateNumber = array_length(_reactionTemplates);
	var _reactionTemplateA = _reactionTemplates[irandom(_reactionTemplateNumber - 1)];
	var _reactionTemplateB = _reactionTemplates[irandom(_reactionTemplateNumber - 1)];
	var _reactionTemplateBStartIndex = _reactionTemplateA[3] + 1;
	var _reactionElements = array_shuffle(global.elements);
	
	var _itemA = array_create(7, -1);
	var _itemB = array_create(7, -1);
	var _swap = false;
	for (var _cell = 0; _cell < 7; _cell++){
		if _reactionTemplateA[_cell] == -1{
			continue;
		}
		
		var _element = _reactionElements[_reactionTemplateA[_cell] % global.elementNumber];
		if _element == s_aether{
			_swap = true;
		}
		
		_itemA[_cell] = _element;
		_itemB[_cell] = _reactionElements[(_reactionTemplateB[_cell] + _reactionTemplateBStartIndex) % global.elementNumber];
	}
	
	reactants[_index] = _swap ? _itemB : _itemA;
	products[_index] = _swap ? _itemA : _itemB;
	
	reactionGrabBagIndex++;
}

function reaction_grab_bag_shuffle(){
	reactionGrabBagElementCount = array_create(0);
	
	for (var i = ELEMENT_COUNT.ONE; i < ELEMENT_COUNT.NUMBER; i++){
		while grabBagModulator[i] >= 1{
			array_push(reactionGrabBagElementCount, i);
			grabBagModulator[i]--;
		}
	}
	//for (var i = ELEMENT_COUNT.ONE; i < ELEMENT_COUNT.NUMBER; i++){
	//	grabBagModulator[i] += 7/global.ELEMENT_COUNT_INT[i];
	//}
	array_shuffle_ext(reactionGrabBagElementCount);

	reactionGrabBagIndex = 0;
}

function scan_for_matches(){
	matches = array_create(sqr(11), 0);
	for (var i = 0; i < 3; i++){
		var _reactant = reactants[i];
		var _mask = (0b1 << i)
		for (var _cell = 0; _cell < sqr(11); _cell++){
			if hexes[_cell] == -1{
				continue;
			}
			
			if not does_match(hexes[_cell], _reactant[3]){
				continue;
			}
			
			
			var _iPos = _cell % 11;
			var _jPos = floor(_cell/11);
			var _oddEven = 1 - (_iPos & 0b1);
			
			var _upLeftCell = _iPos - 1 + (_jPos - 1 + _oddEven)*11;
			var _downLeftCell = _iPos - 1 + (_jPos + _oddEven)*11;
			var _upRightCell = _iPos + 1 + (_jPos - 1 + _oddEven)*11;
			var _downRightCell = _iPos + 1 + (_jPos + _oddEven)*11;
			var _upCell = _iPos + (_jPos - 1)*11;
			var _downCell = _iPos + (_jPos + 1)*11;
			
			var _cellsToMatch = [];
			if _reactant[0] != -1{
				array_push(_cellsToMatch, _upLeftCell);
				if not (_iPos - 1 >= 0 and _jPos - 1 + _oddEven >= 0 and does_match(hexes[_upLeftCell], _reactant[0])){
					continue;
				}
			}
			if _reactant[1] != -1{
				array_push(_cellsToMatch, _downLeftCell);
				if not (_iPos - 1 >= 0 and _jPos + _oddEven < 11 and does_match(hexes[_downLeftCell], _reactant[1])){
					continue;
				}
			}
			if _reactant[2] != -1{
				array_push(_cellsToMatch, _upCell);
				if not (_jPos - 1 >= 0 and does_match(hexes[_upCell], _reactant[2])){
					continue;
				}
			}
			if _reactant[4] != -1{
				array_push(_cellsToMatch, _downCell);
				if not (_jPos + 1 < 11 and does_match(hexes[_downCell], _reactant[4])){
					continue;
				}
			}
			if _reactant[5] != -1{
				array_push(_cellsToMatch, _upRightCell);
				if not (_iPos + 1 < 11 and _jPos - 1 + _oddEven >= 0 and does_match(hexes[_upRightCell], _reactant[5])){
					continue;
				}
			}
			if _reactant[6] != -1{
				array_push(_cellsToMatch, _downRightCell);
				if not (_iPos + 1 < 11 and _jPos + _oddEven < 11 and does_match(hexes[_downRightCell], _reactant[6])){
					continue;
				}
			}
			
			if _reactant[0] != -1{
				matches[_upLeftCell] |= _mask;
			}
			if _reactant[1] != -1{
				matches[_downLeftCell] |= _mask;
			}
			if _reactant[2] != -1{
				matches[_upCell] |= _mask;
			}
			matches[_cell] |= _mask;
			if _reactant[4] != -1{
				matches[_downCell] |= _mask;
			}
			if _reactant[5] != -1{
				matches[_upRightCell] |= _mask;
			}
			if _reactant[6] != -1{
				matches[_downRightCell] |= _mask;
			}
		}
	}
}

function does_match(_elementA, _elementB){
	return _elementA == _elementB or ((_elementA == s_aether and _elementB != s_shard) or (_elementA != s_shard and _elementB == s_aether));
}