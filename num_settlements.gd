extends Resource

@export var num_settlements: int
@export var num_cities: int
@export var num_wood: int
@export var num_ore: int
@export var num_wool: int
@export var num_brick: int
@export var num_wheat: int
@export var num_roads: int
func _init(p_settlements = 0, p_cities = 0, p_roads = 0, p_wood = 0, p_ore = 0, p_wool = 0, p_brick = 0, p_wheat = 0):
	num_settlements = p_settlements
	num_cities = p_cities
	num_roads = p_roads
	num_wood = p_wood
	num_ore = p_ore
	num_wool = p_wool
	num_brick = p_brick
	num_wheat = p_wheat
	
	
