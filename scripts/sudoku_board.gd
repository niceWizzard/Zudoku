extends GridContainer
class_name SudokuBoard


var tile_map : Dictionary = {}

var tile_peers_map : Dictionary = {}

func _ready() -> void:
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
			var tile := get_tile(x,y)
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

func set_tile_peers(x: int, y: int, value: int) -> void:
	var key := "%s:%s" % [x, y]
	for peer : SudokuTile in tile_peers_map[key]:
		peer.set_impossible(value)

func revert_tile_peers(x: int, y: int, value : int) -> void:
	var key := "%s:%s" % [x, y]
	for peer : SudokuTile in tile_peers_map[key]:
		peer.set_possible(value)

func put_tile(x: int, y: int, value: SudokuTile) -> void:
	## Puts a SudokuTile object at the specified x and y coordinates
	var key := str(x, ":", y)
	if tile_map.has(key):
		push_error("SudokuTile already exists at this location. ",key)
	tile_map[key] = value
	value.coordinate = Vector2i(x,y)

func get_tile(x: int, y: int) -> SudokuTile:
	var key := str(x, ":", y)
	if not tile_map.has(key):
		push_error("SudokuTile does not exist at this location. ",key)
	return tile_map[key]

func get_tile_group(i : int, j : int) -> Array[SudokuTile]:
	var tile_group : Array[SudokuTile] = []

	for y in range(3):
		for x in range(3):
			tile_group.push_back(get_tile(
				x + 3 * i,
				y + 3 * j
			))

	return tile_group

func get_tile_group_s(i : int) -> Array[String]:
	var tile_group : Array[String] = []

	for y in range(3):
		for x in range(3):
			tile_group.push_back(
				"%s:%s" % [x + 3 * i, y + 3 * i]
			)

	return tile_group



func reset() -> void:
	for x in range(9):
		for y in range(9):
			get_tile(x,y).reset()
