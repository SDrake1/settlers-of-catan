extends Control

var dice_faces = [ preload("res://DiceImage/Dice1.png"), preload("res://DiceImage/Dice2.png"), preload("res://DiceImage/Dice3.png"), 
preload("res://DiceImage/Dice4.png"), 
preload("res://DiceImage/Dice5.png"),
preload("res://DiceImage/Dice6.png")
]
@onready var timer = $Timer
@onready var dice_button = $TextureButton
var dicenum: int

var is_rolling = false
var roll_duration = 2.0  # Roll duration in seconds
var roll_time_left = 0.0

func _ready() :
	dice_button.texture_normal = dice_faces[0]  #Sets face
	
	# Set up the timer for the rolling effect
	timer.wait_time = 0.1
	var callable = Callable(self, "_on_timer_timeout")
	var callable2 = Callable(self, "_on_texture_button_pressed")
	timer.connect("timeout",callable)
	dice_button.connect("pressed", callable2)
	
	#Event for button
func _on_texture_button_pressed():
	if !is_rolling:
		is_rolling = true
		roll_time_left = roll_duration
		timer.start()  # Start the timer
		

func _on_timer_timeout() :
	# Change the dice face to a random one
	var random_index = randi() % dice_faces.size()
	dice_button.texture_normal = dice_faces[random_index]
	roll_time_left -= timer.wait_time
	# Stop after a certain duration 
	dicenum = random_index + 1
	if roll_time_left <= 0.0:
		dice_button.texture_normal = dice_faces[random_index]
		timer.stop()  # Stop the timer
		is_rolling = false  # Reset the rolling
