extends CanvasGroup


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_text()
	
func round_1():
	#on round 1, everyone places one settlement and one round
	%special_text.text = "Build a settlement and road"
	if Global.beginning_check[Global.current_player][0] == 1 && Global.beginning_check[Global.current_player][1] == 1:
		if Global.current_player < len(Global.players)-1:
			Global.current_player += 1
			change_text()
		else:
			Global.round += 1
			%special_text.text = "Build another settlement and road"
		
#on round 2, order reverses and it happens again
func round_2():
	%special_text.text = "Build another settlement and road"
	if Global.beginning_check[Global.current_player][2] == 1 && Global.beginning_check[Global.current_player][3] == 1:
		if Global.current_player != 0:
			Global.current_player -= 1
			change_text()
		else:
			Global.round += 1
			%die_button.disabled = false
			#remove tutorial text

func _on_button_button_up() -> void:
	#on round 3+ the game continues as normal
	#ROUND 3+
	%special_text.text = ""
	%die_button.disabled = false
	%end_turn.disabled = true
	if Global.current_player < len(Global.players)-1:
		Global.current_player += 1
		change_text()
	else:
		Global.round += 1
		Global.current_player = 0
		change_text()
			
func change_text():
	%current_turn.text = Global.players[Global.current_player] + "'s turn"
