extends Button

var die1_result = 0
var die2_result = 0

var roll_result

func _on_button_up() -> void:
	disabled = true
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
				
	%end_turn.disabled = false
