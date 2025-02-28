extends Control
var num_towns: int = 5
var num_cities: int = 4
var num_roads: int = 15
var num_wood: int
var num_wool: int
var num_ore: int
var num_brick: int
var num_wheat: int
var victory_points: int
var player_name: String

var stylebox = get_theme_stylebox("panel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%PlayerName.text = player_name
	%ColorRect.color = Global.player_colors[Global.players.find(player_name)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%VPCount.text = str(victory_points)
	%TownCount.text = str(num_towns)
	%RoadCount.text = str(num_roads)
	%CitiesCount.text = str(num_cities)
	%BrickCount.text = str(num_brick)
	%WoodCount.text = str(num_wood)
	%WheatCount.text = str(num_wheat)
	%OreCount.text = str(num_ore)
	%WoolCount.text = str(num_wool)
	
func build_town():
	if num_towns > 0 and num_brick >= 1 and num_wheat >= 1 and num_wood >= 1 and num_wool >= 1:
		num_towns -= 1
		victory_points += 1	
		num_brick -= 1
		num_wheat -= 1
		num_wood -= 1
		num_wool -= 1
		return true
	return false
		
func build_city():
	if num_cities > 0 and num_ore >= 3 and num_wheat >= 2:
		num_cities -= 1
		victory_points += 1
		num_ore -= 3
		num_wheat -= 2
		return true
	return false
		
func build_road():
	if num_roads > 0 and num_brick >= 1 and num_wood >= 1:
		num_roads -= 1
		num_brick -= 1
		num_wood -= 1
		return true
	return false
