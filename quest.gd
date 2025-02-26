extends Control
# variables
@onready var button_2 = $HBoxContainer/Button2
@onready var button_3 = $HBoxContainer/Button3
@onready var button_4 = $HBoxContainer/Button4
@onready var NameText = $HBoxContainer2/Name
@onready var Submit = $Submit
@onready var text = $prompt
var input = []
var buttoncheck: int = 0

func _ready() -> void:
	NameText.visible = false
	Submit.visible = false
	var callable = Callable(self, "_on_submit_button_pressed")
	Submit.connect("pressed", callable)
	
func _on_button_2_pressed() -> void:
	buttoncheck = 2
	PlayerData.player_count = 2
	text.text = "Submit 2 names"
	Submit.visible = true
	NameText.visible = true
	button_2.visible = false
	button_3.visible = false
	button_4.visible = false
			

func _on_button_3_pressed() -> void:
	buttoncheck = 3
	PlayerData.player_count = 3
	text.text = "Submit 3 names"
	Submit.visible = true
	NameText.visible = true
	button_2.visible = false
	button_3.visible = false
	button_4.visible = false


func _on_button_4_pressed() -> void:
	buttoncheck = 4
	PlayerData.player_count = 4
	text.text = "Submit 4 names"
	Submit.visible = true
	NameText.visible = true
	button_2.visible = false
	button_3.visible = false
	button_4.visible = false


func _on_submit_pressed() -> void:
	text.text = "Submit a name"
# Loop through the  array to check if the name is already used
	for x in input:
		if NameText.text == x:
			text.text = "That name has already been used."
			return 
	input.append(NameText.text)
	PlayerData.player_names.append(NameText.text)
	# Clear the input field 
	NameText.clear()
	print("Input has added",input)	
	match buttoncheck:
		2:  if input.size() == 2:
				text.text = "Great thats all the players"
				print("Button pressed. input not stored:", input)
				get_tree().change_scene_to_file("res://game_board.tscn")
				return
		3:  if input.size() == 3:
				text.text = "Great thats all the players"
				print("Button pressed. input not stored:", input)
				get_tree().change_scene_to_file("res://game_board.tscn")
				return
		4:  if input.size() == 4:
				text.text = "Great thats all the players"
				print("Button pressed. input not stored:", input)
				get_tree().change_scene_to_file("res://game_board.tscn")
				return
