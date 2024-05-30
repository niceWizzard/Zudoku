extends GutTest


func test_value_setter() -> void:
	var tile := SudokuTile.new()
	gut.p("Testing for value 5")
	tile.value = 5
	assert_eq(tile.value, 5)

	gut.p("Testing for value 0")
	tile.value = 0
	assert_eq(tile.value, 0)


func test_possible_value() -> void:
	var tile := SudokuTile.new()
	gut.p("Testing for possible value")
	assert_eq(tile.possible_values.size(), 9)

	tile.set_impossible(7)
	assert_eq(tile.possible_values.size(), 8)
	assert_eq(tile.possible_values.has(7), false)

	tile.set_possible(7)
	assert_eq(tile.possible_values.size(), 9)
	assert_eq(tile.possible_values.has(7), true)



func test_possible_value_methods() -> void:
	var tile := SudokuTile.new()
	gut.p("Testing set_impossible")

	for i in range(1,10):
		tile.set_impossible(i)
	assert_eq(tile.possible_values.size(), 0)
	
	gut.p("Testing set_possible")

	tile.set_possible(5)
	assert_eq(tile.possible_values.size(), 1)
	assert_true(tile.possible_values.has(5))

	gut.p("Testing set_impossible (individual)")
	tile.set_impossible(5)
	assert_eq(tile.possible_values.size(), 0)
	assert_false(tile.possible_values.has(5))

	gut.p("Testing to enable all possible_values")
	for i in range(9):
		tile.set_possible(i)
	assert_eq(tile.possible_values.size(), 9)

	

  
func test_get_random_possible_value() -> void:
	var tile := SudokuTile.new()
	assert_true(tile.get_random_possible_value() <= 9, "Tile random value should be <= 9")
	assert_true(tile.get_random_possible_value() > 0, "Tile random value should be > 0")

	gut.p("Testing for set_impossible & get_random_value")
	for x in range(9):
		tile.set_impossible(x)
		for i in range(20):
			assert_false(tile.get_random_possible_value() == x, "Possible values should not include %s" % x)
		tile.set_possible(x)

	


func test_reset() -> void:
	var tile := SudokuTile.new()
	tile.reset()
	assert_eq(tile.possible_values.size(), 9)
	assert_eq(tile.value,0)

	

func test_is_set() -> void:
	var tile := SudokuTile.new()
	assert_false(tile.is_set())
	tile.value = 5
	assert_true(tile.is_set())

	tile.reset()
	assert_false(tile.is_set())
	
