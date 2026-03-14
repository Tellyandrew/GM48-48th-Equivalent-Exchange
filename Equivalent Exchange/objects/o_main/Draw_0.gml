/// @description
for (var _cell = 0; _cell < sqr(11); _cell++){
	if is_undefined(hexes[_cell]){
		continue;
	}
		
	draw_sprite(s_fire, 0, hexesXPos[_cell], hexesYPos[_cell]);
}

var _inst = instance_position(mouse_x, mouse_y, o_mask);

if _inst != noone{
	draw_sprite(s_collisionMask, 0, hexesXPos[_inst.cell], hexesYPos[_inst.cell]);
}