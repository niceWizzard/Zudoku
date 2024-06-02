extends GutTest

var b: Board

func before_all() -> void:
	b = Board.new()


func test_create() -> void:

	assert_eq(b.board_map.size(), 81, "Board size is not 81")
	assert_eq(b.peers_map.size(), 81, "Peers size is not 81")

	assert_eq(b.peers_map.get(Vector2i()).size(), 20, "Peers size is not 20 but %s" % b.peers_map.get(Vector2i()).size())

func test_get_tile() -> void:

	assert_eq(b.get_tile(Vector2i(0, 0)), 0, "Tile is not 0")
	assert_eq(b.get_tile(Vector2i(8, 8)), 0, "Tile is not 0")
	assert_eq(b.get_tile(Vector2i(4, 4)), 0, "Tile is not 0")

	assert_eq(b.get_tile(Vector2i(-1, -1)), -1, "Tile should be -1 when invalid coord is given but %s is returned" % b.get_tile(Vector2i(-1, -1)))
	assert_eq(b.get_tile(Vector2i(9, 9)), -1, "Tile should be -1 when invalid coord is given but %s is returned" % b.get_tile(Vector2i(9, 9)))

func test_get_tilei() -> void:

	assert_eq(b.get_tilei(0, 0), 0, "Tile is not 0")

	for y in range(3):
		for x in range(3):
			assert_eq(b.get_tilei(x, y), b.get_tile(Vector2i(x,y)), "Tile returned by get_tilei should be equal to get_tile")

func test_get_peers() -> void:
	var peer := b.get_peers(Vector2i(0, 0))
	assert_eq(peer.size(), 20, "Peers size is not 20 but %s" % peer.size())

	var empty := b.get_peers(Vector2i(-1,-1))
	assert_eq(empty.size(), 0, "Peers size of invalid coordinate is not 0 but %s" % empty.size())

	
	for i in range(9):
		var row := Vector2i(0, i)
		if row != Vector2i(0, 0):
			assert_true(peer.has(row), "(0,0) should have peer %s" % row)
		var col := Vector2i(i, 0)
		if col != Vector2i(0, 0):
			assert_true(peer.has(col), "(0,0) should have peer %s" % col)

func test_is_valid_for_tile() -> void:
	for i in range(1,10):
		assert_true(b.is_valid_for_tile(Vector2i(0, 0), i), "Value %s should be valid for tile (0,0)" % i)

	b.set_tile(Vector2i(1,0), 1)
	assert_false(b.is_valid_for_tile(Vector2i(0, 0), 1), "Value 1 should not be valid for tile (0,0)")

	b.set_tile(Vector2i(5,5), 5 )
	assert_true(b.is_valid_for_tile(Vector2i(0, 0), 5), "Value 5 should be valid for tile (0,0)")

func test_set_tile() -> void:
	b.set_tile(Vector2i(), 1)
	assert_eq(b.get_tile(Vector2i()), 1, "Tile (0,0) should be 1 but got %s" % b.get_tile(Vector2i()))

	b.set_tile(Vector2i(8,8), 9)
	assert_eq(b.get_tile(Vector2i(8,8)), 9, "Tile (8,8) should be 9 but got %s" % b.get_tile(Vector2i(8,8)))

	b.set_tile(Vector2i(), 0)
	assert_eq(b.get_tile(Vector2i()), 0, "Tile (0,0) should be 0 but got %s" % b.get_tile(Vector2i()))

func test_solve() -> void:
	assert_true(b.solve(Vector2i(0, 0)), "Board should be solvable")
	
	for y in range(9):
		for x in range(9):
			assert_ne(b.get_tile(Vector2i(x, y)), 0, "Tile (%s, %s) should not be 0" % [x, y])
			for peer : Vector2i in b.get_peers(Vector2i(x, y)):
				assert_ne(b.get_tile(Vector2i(x, y)), b.get_tile(peer), "Tile (%s, %s) should not be equal to its peer %s" % [x,y ,peer])

	for y in range(9):
		for x in range(9):
			var coord := Vector2i(x, y)
			var tile := b.get_tile(coord)
			for i in range(9):
				var col := Vector2i(i, y)
				if col != coord:
					assert_ne(tile, b.get_tile(col), "Tile (%s, %s) should not be equal to its peer %s" % [x,y ,col])
				var row := Vector2i(x, i)
				if row != coord:
					assert_ne(tile, b.get_tile(row), "Tile (%s, %s) should not be equal to its peer %s" % [x,y ,row])

	# b = Board.new()
	# for y in range(9):
	#     for x in range(9):
	#         b.set_tile(Vector2i(x,y), 1)

	# assert_false(b.solve(Vector2()), "Board should not be solvable")

func test_generate() -> void:
	var board := Board.generate()
	assert_true(board.solve(), "Board should be solveable since it is already solved.")

func test_multiple_solve() -> void:
	for j in range(5):
		b = Board.new()
		assert_true(b.solve(Vector2i(0, 0)), "Board should be solvable")
		for y in range(9):
			for x in range(9):
				assert_ne(b.get_tile(Vector2i(x, y)), 0, "Tile (%s, %s) should not be 0" % [x, y])
				for peer : Vector2i in b.get_peers(Vector2i(x, y)):
					assert_ne(b.get_tile(Vector2i(x, y)), b.get_tile(peer), "Tile (%s, %s) should not be equal to its peer %s" % [x,y ,peer])

		for y in range(9):
			for x in range(9):
				var coord := Vector2i(x, y)
				var tile := b.get_tile(coord)
				for i in range(9):
					var col := Vector2i(i, y)
					if col != coord:
						assert_ne(tile, b.get_tile(col), "Tile (%s, %s) should not be equal to its peer %s" % [x,y ,col])
					var row := Vector2i(x, i)
					if row != coord:
						assert_ne(tile, b.get_tile(row), "Tile (%s, %s) should not be equal to its peer %s" % [x,y ,row])

	
func test_create_from() -> void:
	var board := Board.create_from("003020600900305001001806400008102900700000008006708200002609500800203009005010300")
	assert_eq(
		board.get_tilei(2, 0),
		3,
		"Value of tile (2,0) should be 3"
	)
	assert_eq(
		board.get_tilei(4, 0),
		2,
		"Value of tile (4,0) should be 2"
	)

	assert_true(board.solve(), "Board should be solveable.")

	assert_eq(
		board.get_tilei(8,8),
		2,
		"Tile (8,8) should be 2 since it is a unique puzzle."
	)

	assert_null(Board.create_from(""), "create_from should return null when string is empty.")
	assert_null(Board.create_from("lakdjalskdfjlasdfklasdfjadsklkladslasdkfjkldsjlads"), "Should return null when puzzle string is not 81")

