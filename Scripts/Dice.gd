extends Control

var dice_faces = [preload("res://Dice/Dice1.png"), preload("res://Dice/Dice2.png"), preload("res://Dice/Dice3.png"), 
preload("res://Dice/Dice4.png"), 
preload("res://Dice/Dice5.png"),
preload("res://Dice/Dice6.png")
]

@onready var timer = $Timer
@onready var dice = $TextureRect
var dicenum: int

var is_rolling = false
var roll_duration = 1  # Roll duration in seconds
var roll_time_left = 0.0

func _ready() :
	dice.texture = dice_faces[0]  #Sets face
	
	# Set up the timer for the rolling effect
	timer.wait_time = 0.1
	var callable = Callable(self, "_on_timer_timeout")
	timer.connect("timeout",callable)
	
func roll():
	if !is_rolling:
		is_rolling = true
		roll_time_left = roll_duration
		timer.start()  # Start the timer

func _on_timer_timeout() :
	# Change the dice face to a random one
	var random_index = randi() % dice_faces.size()
	dice.texture = dice_faces[random_index]
	roll_time_left -= timer.wait_time
	# Stop after a certain duration 
	dicenum = random_index + 1
	if roll_time_left <= 0.0:
		dice.texture = dice_faces[random_index]
		timer.stop()  # Stop the timer
		is_rolling = false  # Reset the rolling
		get_parent().die_result(name, dicenum)
