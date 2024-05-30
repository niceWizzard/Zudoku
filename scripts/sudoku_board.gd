extends GridContainer
class_name SudokuBoard


var tile_map : Dictionary = {}

var tile_peers_map : Dictionary = {}

func _ready():
	# Get all the tileviews
	for main_grid_col in get_children().size():
		var tile_group := get_children()[main_grid_col].get_children()
		for tile_group_index in tile_group.size():
			var tile_view := tile_group[tile_group_index]
			var x := (main_grid_col % 3)*3 + (tile_group_index % 3)
			var y := (main_grid_col / 3)*3 + ( tile_group_index / 3)
			put_tile(x,y, tile_view)

	for y in range(0,9):
		for x in range(0,9):
			var tile = get_tile(x,y)
			var key := "%s:%s" % [x, y]
			var peers : Array[SudokuTile] = []
			for i in range(0,9):
				# Tiles in the same column
				var same_col := get_tile(i,y)
				if !peers.has(same_col) and same_col != tile:
					peers.append(same_col)

				# Tiles in the same row
				var same_row := get_tile(x,i)
				if !peers.has(same_row) and same_row != tile:
					peers.append(same_row)
				
				# Tiles in the same 3x3 grid
				var grid_x := (x / 3) * 3 + i % 3
				var grid_y := (y / 3) * 3 + i / 3
				var same_grid := get_tile(grid_x,grid_y)
				if !peers.has(same_grid) and same_grid != tile:
					peers.append(same_grid)				
			tile_peers_map[key] = peers

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
