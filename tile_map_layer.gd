extends TileMapLayer

func rand_tile(n: int) -> String:
	
	var tile_types = ["ocean", "forest", "desert", "pasture", "mountains", "hills", "fields"]
	return tile_types[n]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var game_board = [Vector2i(4,1), Vector2i(5,1), Vector2i(6,1),
		Vector2i(4,2), Vector2i(5,2), Vector2i(6,2), Vector2i(7,2),
		Vector2i(3,3), Vector2i(4,3), Vector2i(5,3), Vector2i(6,3), Vector2i(7,3),
		Vector2i(4,4), Vector2i(5,4), Vector2i(6,4), Vector2i(7,4),
		Vector2i(4,5), Vector2i(5,5), Vector2i(6,5)]
	var atlas_id = 2;
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
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
