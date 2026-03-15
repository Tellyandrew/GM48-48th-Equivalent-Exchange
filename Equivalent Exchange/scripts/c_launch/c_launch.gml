global.elements = [s_water, s_fire, s_earth, s_air, s_aether];
global.elementNumber = array_length(global.elements);
randomize();

enum REACTION_TYPE{
	ONE,
	TWO_NORTH,
	TWO_EAST,
	TWO_WEST,
	THREE_EAST,
	THREE_WEST,
	FOUR_GLOB_NORTH,
	FOUR_GLOB_EAST,
	FOUR_GLOB_WEST,
	FOUR_T_NORTH,
	FOUR_T_SOUTH,
	SEVEN,
	
	NUMBER,
}

enum ELEMENT_COUNT{
	ONE,
	TWO,
	THREE,
	FOUR,
	SEVEN,
	
	NUMBER
}

global.ELEMENT_COUNT_INT = array_create(ELEMENT_COUNT.NUMBER);
global.ELEMENT_COUNT_INT[ELEMENT_COUNT.ONE] = 1;
global.ELEMENT_COUNT_INT[ELEMENT_COUNT.TWO] = 2;
global.ELEMENT_COUNT_INT[ELEMENT_COUNT.THREE] = 3;
global.ELEMENT_COUNT_INT[ELEMENT_COUNT.FOUR] = 4;
global.ELEMENT_COUNT_INT[ELEMENT_COUNT.SEVEN] = 7;

global.REACTION_SHAPES = array_create(ELEMENT_COUNT.NUMBER);
global.REACTION_SHAPES[ELEMENT_COUNT.ONE] = [REACTION_TYPE.ONE];
global.REACTION_SHAPES[ELEMENT_COUNT.TWO] = [REACTION_TYPE.TWO_NORTH, REACTION_TYPE.TWO_EAST, REACTION_TYPE.TWO_WEST];
global.REACTION_SHAPES[ELEMENT_COUNT.THREE] = [REACTION_TYPE.THREE_EAST, REACTION_TYPE.THREE_WEST];
global.REACTION_SHAPES[ELEMENT_COUNT.FOUR] = [REACTION_TYPE.FOUR_GLOB_NORTH, REACTION_TYPE.FOUR_GLOB_EAST, REACTION_TYPE.FOUR_GLOB_WEST, REACTION_TYPE.FOUR_T_NORTH, REACTION_TYPE.FOUR_T_SOUTH];
global.REACTION_SHAPES[ELEMENT_COUNT.SEVEN] = [REACTION_TYPE.SEVEN];

global.REACTION_TEMPLATES = array_create(REACTION_TYPE.NUMBER);
global.REACTION_TEMPLATES[REACTION_TYPE.ONE] = [[-1, -1, -1, 0, -1, -1, -1]];
global.REACTION_TEMPLATES[REACTION_TYPE.TWO_NORTH] = [[-1, -1, 0, 0, -1, -1, -1], [-1, -1, 0, 1, -1, -1, -1]];
global.REACTION_TEMPLATES[REACTION_TYPE.TWO_EAST] = [[-1, -1, -1, 0, -1, -1, 0], [-1, -1, -1, 1, -1, -1, 0]];
global.REACTION_TEMPLATES[REACTION_TYPE.TWO_WEST] = [[-1, 0, -1, 0, -1, -1, -1], [-1, 0, -1, 1, -1, -1, -1]];
global.REACTION_TEMPLATES[REACTION_TYPE.THREE_EAST] = [
	[-1, -1, -1, 0, -1, 0, 0],
	[-1, -1, -1, 1, -1, 0, 0],
	[-1, -1, -1, 1, -1, 0, 1],
	[-1, -1, -1, 1, -1, 1, 0],
	[-1, -1, -1, 2, -1, 1, 0],
];
global.REACTION_TEMPLATES[REACTION_TYPE.THREE_WEST] = [
	[0, 0, -1, 0, -1, -1, -1],
	[1, 0, -1, 1, -1, -1, -1],
	[0, 1, -1, 1, -1, -1, -1],
	[0, 0, -1, 1, -1, -1, -1],
	[0, 1, -1, 2, -1, -1, -1],
];
global.REACTION_TEMPLATES[REACTION_TYPE.FOUR_GLOB_NORTH] = [
	[0, -1, 0, 0, -1, 0, -1],
	[0, -1, 0, 1, -1, 1, -1],
	[1, -1, 0, 1, -1, 0, -1],
	[0, -1, 1, 1, -1, 0, -1],
	[3, -1, 1, 0, -1, 2, -1],
];
global.REACTION_TEMPLATES[REACTION_TYPE.FOUR_GLOB_EAST] = [
	[-1, -1, -1, 0, 0, 0, 0],
	[-1, -1, -1, 1, 1, 0, 0],
	[-1, -1, -1, 1, 0, 1, 0],
	[-1, -1, -1, 1, 0, 0, 1],
	[-1, -1, -1, 3, 2, 1, 0],
];
global.REACTION_TEMPLATES[REACTION_TYPE.FOUR_GLOB_WEST] = [
	[0, 0, -1, 0, 0, -1, -1],
	[1, 0, -1, 1, 0, -1, -1],
	[0, 1, -1, 1, 0, -1, -1],
	[0, 0, -1, 1, 1, -1, -1],
	[0, 1, -1, 2, 3, -1, -1],
];
global.REACTION_TEMPLATES[REACTION_TYPE.FOUR_T_NORTH] = [
	[-1, 0, 0, 0, -1, -1, 0],
	[-1, 0, 0, 1, -1, -1, 0],
	[-1, 1, 2, 3, -1, -1, 0],
];
global.REACTION_TEMPLATES[REACTION_TYPE.FOUR_T_SOUTH] = [
	[0, -1, -1, 0, 0, 0, -1],
	[0, -1, -1, 1, 0, 0, -1],
	[0, -1, -1, 3, 2, 1, -1],
];
global.REACTION_TEMPLATES[REACTION_TYPE.SEVEN] = [
	[0, 0, 0, 0, 0, 0, 0],
	[0, 1, 1, 1, 0, 0, 1],
	[1, 0, 0, 1, 1, 1, 0],
	[0, 0, 0, 1, 0, 0, 0],
	[1, 0, 0, 2, 1, 1, 0],
	[1, 2, 0, 3, 0, 2, 1],
];