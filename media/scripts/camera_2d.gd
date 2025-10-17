extends Camera2D



func _ready():
	
	var tilemap = get_tree().get_current_scene().get_node("TileMap")
	if tilemap:
		var used_rect = tilemap.get_used_rect()
		var cell_size = tilemap.tile_set.tile_size

		var level_rect = Rect2(
			used_rect.position * cell_size,
			used_rect.size * cell_size
		)

		limit_left = int(level_rect.position.x)
		limit_top = int(level_rect.position.y)
		limit_right = int(level_rect.position.x + level_rect.size.x)
		limit_bottom = int(level_rect.position.y + level_rect.size.y)
