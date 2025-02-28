extends TileMapLayer

var game_board = [Vector2i(4,1), Vector2i(5,1), Vector2i(6,1),
		Vector2i(4,2), Vector2i(5,2), Vector2i(6,2), Vector2i(7,2),
		Vector2i(3,3), Vector2i(4,3), Vector2i(5,3), Vector2i(6,3), Vector2i(7,3),
		Vector2i(4,4), Vector2i(5,4), Vector2i(6,4), Vector2i(7,4),
		Vector2i(4,5), Vector2i(5,5), Vector2i(6,5)]
		
var player_board_scene = preload("res://Scenes/player_board.tscn")
func rand_tile(n: int) -> String:
	var tile_types = ["ocean", "mountains", "desert", "fields", "hills", "forest", "pasture"]
	return tile_types[n]

func resource_numbers():
	var num_occurances = [2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12]
	num_occurances.shuffle()
	
	#for int up to 19, if cell in game board != desert, randomize number from list
	#change label
	for i in range(19):
		if get_cell_atlas_coords(game_board[i]) == Vector2i(2, 0):
			%numbers.get_child(i).visible = false
		else:
			var rand = randi_range(0, num_occurances.size()-1)
			var num = num_occurances.pop_at(rand)
			%numbers.get_child(i).text = str(num)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var atlas_id = 3;
	var tiles_available = {"forest": 4, "desert": 1, "pasture": 4, "mountains": 3,
			"hills": 3, "fields": 4}
	
	var tile_occurences = {"forest": 0, "desert": 0, "pasture": 0, "mountains": 0, "hills": 0, "fields": 0}
	for cell in game_board:
		var rand = randi_range(1, 6)
		var tile = rand_tile(rand);
		tile_occurences[tile] += 1
		while tile_occurences[tile] > tiles_available[tile]:
			rand = randi_range(1, 6)
			tile = rand_tile(rand);
			tile_occurences[tile] += 1
		set_cell(cell, atlas_id, Vector2i(rand, 0))
		
	resource_numbers()
	for p_name in Global.players:
		var player_board = player_board_scene.instantiate()
		player_board.get_child(1).name = p_name
		player_board.get_child(1).player_name = p_name
		%PlayerBoards.add_child(player_board)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
