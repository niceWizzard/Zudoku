class_name SudokuSolver
extends RefCounted

var board : SudokuBoard

func _init(b : SudokuBoard) -> void:
	assert(b != null, "Provided board in solver is null.")
	self.board = b


func generate_board() -> void:
	for y in range(9):
		for x in range(9):
			var tile := board.get_tile(x,y)
			var key := "%s:%s" % [x,y]
			var value := tile.get_random_possible_value()
			if value < 0:
				continue
			tile.value = value
			for peer : SudokuTile in board.tile_peers_map[key]:
				peer.set_impossible(value)
			





