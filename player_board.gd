extends Control
var num_towns: int
var num_cities: int
var num_roads: int
var num_wood: int
var num_wool: int
var num_ore: int
var num_brick: int
var num_wheat: int
var victory_points: int
var player_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%PlayerName.text = player_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func build_town():
	if num_towns < 5 and num_brick >= 1 and num_wheat >= 1 and num_wood >= 1 and num_wool >= 1:
		num_towns += 1
		victory_points += 1	
		num_brick -= 1
		num_wheat -= 1
		num_wood -= 1
		num_wool -= 1
func build_city():
	if num_cities < 4 and num_ore >= 3 and num_wheat >= 2:
		num_cities += 1
		victory_points += 2
		num_ore -= 3
		num_wheat -= 2
func build_road():
	if num_brick >= 1 and num_wood >= 1:
		num_roads += 1
		num_brick -= 1
		num_wood -= 1
