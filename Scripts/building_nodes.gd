extends Node2D

var selected : Area2D

var road_img = preload("res://Assets/street.png")
var city_img = preload("res://Assets/city.png")
var settlement_img = preload("res://Assets/settlement.png")

var settlement_scene = preload("res://Scenes/Building.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for group in get_children():
		for area:Area2D in group.get_children():
			if area is not Area2D:
				continue
				
			area.mouse_entered.connect(func():
				var my_area := area
				highlight_area(my_area))
				
			area.mouse_exited.connect(func():
				var my_area := area
				unhighlight_area(my_area))

func highlight_area(area:Area2D):
	%highlight.global_position = area.global_position
	%highlight.visible = true
	selected = area
	
func unhighlight_area(area:Area2D):
	%highlight.visible = false
	selected = null
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action_released("click"):
		if selected:
			var parent = selected.get_parent()
			match parent.name:
				"buildings":
					if !selected.get_node("Building"):
						#create instance of building
						var new_building = settlement_scene.instantiate()
						new_building.modulate = Global.player_colors[Global.current_player]
						selected.add_child(new_building)
						
						#do building logic
						#if first or second turn, players must build one settlement and one road off of it
						#every other turn after that, settlements must be touching a road of same color
						#settlements cannot be built if there is another building one road away 
						
					elif selected.get_node("Building").texture == settlement_img:
						selected.get_node("Building").texture = city_img
						
					else:
						pass
						
				#only build if touching settlement, city, or another road of the same color
				"ne_sw roads":
					var road = Sprite2D.new()
					road.texture = road_img
					road.scale = Vector2(1.1, 1.1)
					road.rotation = deg_to_rad(-33)
					road.modulate = Global.player_colors[Global.current_player]
					selected.add_child(road)
					
				"nw_se roads":
					var road = Sprite2D.new()
					road.texture = road_img
					road.scale = Vector2(1.1, 1.1)
					road.rotation = deg_to_rad(33)
					road.modulate = Global.player_colors[Global.current_player]
					selected.add_child(road)
					
				"straight roads":
					var road = Sprite2D.new()
					road.texture = road_img
					road.scale = Vector2(1.1, 1.1)
					road.rotation = deg_to_rad(90)
					road.modulate = Global.player_colors[Global.current_player]
					selected.add_child(road)
