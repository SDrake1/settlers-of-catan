extends CanvasGroup


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_text()


func _on_button_button_up() -> void:
	#on round 1, everyone places one settlement and one round
	#on round 2, order reverses and it happens again
	#on round 3+ the game continues as normal
	if Global.round == 1:
		if Global.current_player < len(Global.players)-1:
			Global.current_player += 1
			change_text()
		else:
			Global.round += 1
			
	elif Global.round == 2:
		if Global.current_player != 0:
			Global.current_player -= 1
			change_text()
		else:
			Global.round += 1
			
	else:
		if Global.current_player < len(Global.players)-1:
			Global.current_player += 1
			change_text()
		else:
			Global.round += 1
			Global.current_player == 0
			change_text()
			
func change_text():
	%current_turn.text = Global.players[Global.current_player] + "'s turn"
