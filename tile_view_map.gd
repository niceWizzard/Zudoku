## A class to store the 9x9 tileview of the sudoku board
extends Object
class_name TileViewMap

var tile_map : Dictionary = {}


func put(x: int, y: int, value: TileView) -> void:
	## Puts a TileView object at the specified x and y coordinates
	var key = str(x, ":", y)
	if tile_map.has(key):
		push_error("TileView already exists at this location. ",key)
	tile_map[key] = value

func get_tile(x: int, y: int) -> TileView:
	var key = str(x, ":", y)
	if not tile_map.has(key):
		push_error("TileView does not exist at this location. ",key)
	return tile_map[key]

