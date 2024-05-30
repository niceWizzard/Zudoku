extends GridContainer
class_name SudokuBoard


var tile_map : Dictionary = {}

var tile_partners_map : Dictionary = {}

func _ready():
	# Get all the tileviews
	for main_grid_col in get_children().size():
		var tile_group := get_children()[main_grid_col].get_children()
		for tile_group_index in tile_group.size():
			var tile_view := tile_group[tile_group_index]
			var x := (main_grid_col % 3)*3 + (tile_group_index % 3)
			var y := (main_grid_col / 3)*3 + ( tile_group_index / 3)
			put_tile(x,y, tile_view)


func put_tile(x: int, y: int, value: SudokuTile) -> void:
	## Puts a SudokuTile object at the specified x and y coordinates
	var key = str(x, ":", y)
	if tile_map.has(key):
		push_error("SudokuTile already exists at this location. ",key)
	tile_map[key] = value

func get_tile(x: int, y: int) -> SudokuTile:
	var key = str(x, ":", y)
	if not tile_map.has(key):
		push_error("SudokuTile does not exist at this location. ",key)
	return tile_map[key]
