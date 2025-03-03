extends Button

var die1_result = 0
var die2_result = 0

var roll_result

func _on_button_up() -> void:
	disabled = true
	%dice_audio.play()
	for node in %numbers.get_children():
		node["theme_override_colors/font_color"] = Color.BLACK
	%die1.roll()
	%die2.roll()

func die_result(die : String, dienum : int):
	if die == "die1":
		die1_result = dienum
	elif die == "die2":
		die2_result = dienum
	
	if die1_result != 0 && die2_result != 0:
		roll_result = die1_result + die2_result
		die1_result = 0
		die2_result = 0
		find_resources()

func find_resources():
	if roll_result == 7:
		%special_text.text = "Unlucky"
	else:
		for node in %numbers.get_children():
			if node.text == str(roll_result):
				node["theme_override_colors/font_color"] = Color.RED
				#create a way to look at what resources people get
				var num_index = %numbers.get_children().find(node)
				var resource_tile = $"../..".get_cell_atlas_coords($"../..".game_board[num_index])
				var res : int
				var player_index : int
					
				for area in %area_checks.get_child(num_index).get_overlapping_areas():
					if area.get_parent().name == "buildings" && area.get_children().size() > 1:
						if area.get_child(1).texture == load("res://Assets/settlement.png"):
							res = 1
						elif area.get_child(1).texture == load("res://Assets/city.png"):
							res = 2
							
						player_index = Global.player_colors.find(area.get_child(1).modulate)
						
					#check resource type
						if resource_tile == Vector2i(1, 0):
							%PlayerBoards.get_child(player_index).get_child(1).num_ore += res
						elif resource_tile == Vector2i(3, 0):
							%PlayerBoards.get_child(player_index).get_child(1).num_wheat += res
						elif resource_tile == Vector2i(4, 0):
							%PlayerBoards.get_child(player_index).get_child(1).num_brick += res
						elif resource_tile == Vector2i(5, 0):
							%PlayerBoards.get_child(player_index).get_child(1).num_wood += res
						elif resource_tile == Vector2i(6, 0):
							%PlayerBoards.get_child(player_index).get_child(1).num_wool += res
				
	%end_turn.disabled = false
