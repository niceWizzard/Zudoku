class_name SudokuSolver
extends RefCounted

var board : SudokuBoard

func _init(b : SudokuBoard) -> void:
	assert(b != null, "Provided board in solver is null.")
	self.board = b


func generate_board() -> void:
	# Fill the independent groups first
	for i in range(3):
		for tile : SudokuTile in board.get_tile_group(i,i):
			tile.value = tile.get_random_possible_value()
			board.set_tile_peers(tile.coordinate.x, tile.coordinate.y, tile.value)

	fill_tile(get_min_tile())

func get_min_tile() -> SudokuTile:
	var min_tile : SudokuTile = null
	var min_tile_val : int = 10
	for x in range(9):
		for y in range(9):
			var tile := board.get_tile(x,y)
			if tile.is_set():
				continue
			var num_possible_values := tile.possible_values.size()
			if num_possible_values < min_tile_val:
				min_tile_val = num_possible_values
				min_tile = tile
	return min_tile

func fill_tile(tile : SudokuTile) -> bool:
	if tile == null:
		return true
	var coord := tile.coordinate
	if tile.is_set():
		return true
	var tried_values := PackedInt32Array()

	var stack := 0
	const MAX_LOOP := 1_000
	while stack < MAX_LOOP:
		var pos_val := tile.get_random_possible_value()
		if tried_values.has(pos_val):
			if tried_values.size() == tile.possible_values.size():
				return false
			continue
		if pos_val == -1:
			return false
		board.set_tile_peers(tile.coordinate.x, tile.coordinate.y, pos_val)
		tile.value = pos_val
		tried_values.append(pos_val)
		var is_safe := fill_tile(get_min_tile())
		if not is_safe:
			board.revert_tile_peers(tile.coordinate.x, tile.coordinate.y, pos_val)
			tile.value = 0
			stack += 1
			if stack == MAX_LOOP:
				push_error("Max loop reached.")
				return false
			continue
		break
	return true


