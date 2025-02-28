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
						if Global.round >= 3 && %PlayerBoards.get_child(Global.current_player).get_child(1).build_town():
							settlement()
							
						elif Global.round == 1 && Global.beginning_check[Global.current_player][0] == 0:
							settlement()
							Global.beginning_check[Global.current_player][0] = 1
							%PlayerBoards.get_child(Global.current_player).get_child(1).victory_points += 1
							%PlayerBoards.get_child(Global.current_player).get_child(1).num_towns -= 1
							%turn_track.round_1()
							
						elif Global.round == 2 && Global.beginning_check[Global.current_player][2] == 0:
							settlement()
							Global.beginning_check[Global.current_player][2] = 1
							%PlayerBoards.get_child(Global.current_player).get_child(1).victory_points += 1
							%PlayerBoards.get_child(Global.current_player).get_child(1).num_towns -= 1
							%turn_track.round_2()
							
					elif selected.get_node("Building").texture == settlement_img && selected.get_node("Building").modulate == Global.player_colors[Global.current_player]:
						if %PlayerBoards.get_child(Global.current_player).get_child(1).build_city():
							selected.get_node("Building").texture = city_img
						
					else:
						pass
						
				#build road based on rotation
				"ne_sw roads":
					if Global.round >= 3 && %PlayerBoards.get_child(Global.current_player).get_child(1).build_road():
						road(-33)
						
					elif Global.round == 1 && Global.beginning_check[Global.current_player][1] == 0:
						road(-33)
						Global.beginning_check[Global.current_player][1] = 1
						%PlayerBoards.get_child(Global.current_player).get_child(1).num_roads -= 1
						%turn_track.round_1()
						
					elif Global.round == 2 && Global.beginning_check[Global.current_player][3] == 0:
						road(-33)
						Global.beginning_check[Global.current_player][3] = 1
						%PlayerBoards.get_child(Global.current_player).get_child(1).num_roads -= 1
						%turn_track.round_2()
					
				"nw_se roads":
					if Global.round >= 3 && %PlayerBoards.get_child(Global.current_player).get_child(1).build_road():
						road(33)
					
					elif Global.round == 1 && Global.beginning_check[Global.current_player][1] == 0:
						road(33)
						Global.beginning_check[Global.current_player][1] = 1
						%PlayerBoards.get_child(Global.current_player).get_child(1).num_roads -= 1
						%turn_track.round_1()
						
					elif Global.round == 2 && Global.beginning_check[Global.current_player][3] == 0:
						road(33)
						Global.beginning_check[Global.current_player][3] = 1
						%PlayerBoards.get_child(Global.current_player).get_child(1).num_roads -= 1
						%turn_track.round_2()
					
				"straight roads":
					if Global.round >= 3 && %PlayerBoards.get_child(Global.current_player).get_child(1).build_road():
						road(90)
					
					elif Global.round == 1 && Global.beginning_check[Global.current_player][1] == 0:
						road(90)
						Global.beginning_check[Global.current_player][1] = 1
						%PlayerBoards.get_child(Global.current_player).get_child(1).num_roads -= 1
						%turn_track.round_1()
						
					elif Global.round == 2 && Global.beginning_check[Global.current_player][3] == 0:
						road(90)
						Global.beginning_check[Global.current_player][3] = 1
						%PlayerBoards.get_child(Global.current_player).get_child(1).num_roads -= 1
						%turn_track.round_2()

func road(rot):
	var road = Sprite2D.new()
	road.texture = road_img
	road.scale = Vector2(1.1, 1.1)
	road.rotation = deg_to_rad(rot)
	road.modulate = Global.player_colors[Global.current_player]
	selected.add_child(road)
	
func settlement():
	#create instance of building
	var new_building = settlement_scene.instantiate()
	new_building.modulate = Global.player_colors[Global.current_player]
	selected.add_child(new_building)
