extends GutTest


var board := SudokuBoard.new()

func before_all() -> void:
	wait_seconds(0.01)
	

func test_board_size() -> void:
	gut.p("Testing board size")
	assert_eq(board.tile_map.values().size(), 81)

func test_put_tiles() -> void:
	var tile := SudokuTile.new()
	board.put_tile(10, 10, tile)
	assert_eq(board.get_tile(10, 10), tile)


func test_peer_map_size() -> void:
	assert_eq(board.tile_peers_map.size(), 81)
	assert_eq(board.tile_peers_map["1:8"].size(), 20)
	for y in range(9):
		for x in range(9):
			assert_eq(board.tile_peers_map[str(x) + ":" + str(y)].size(), 20)

func test_set_tile_peers() -> void:
	board.set_tile_peers(0,0, 1)
	for i in range(1,9):
		assert_false(board.get_tile(i,0).possible_values.has(1))
	for i in range(1,3):
		for j in range(1,3):
			assert_false(board.get_tile(i,j).possible_values.has(1))

	board.revert_tile_peers(0,0,1)

func test_revert_tile_peers() -> void:
	board.set_tile_peers(0,0, 1)
	board.revert_tile_peers(0,0,1)
	for i in range(9):
		assert_true(board.get_tile(i,0).possible_values.has(1))
	for i in range(3):
		for j in range(3):
			assert_true(board.get_tile(i,j).possible_values.has(1))

func test_tile_coordinates() -> void:
	for y in range(9):
		for x in range(9):
			assert_eq(board.get_tile(x,y).coordinate, Vector2i(x,y))

