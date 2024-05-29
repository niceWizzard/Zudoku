extends GutTest

const tile_scn := preload("uid://0i0m6jeakc54")

func test_value_setter():
    var tile := tile_scn.instantiate() as SudokuTile
    gut.p("Testing for value 5")
    tile.value = 5
    assert_eq(tile.get_node("MarginContainer/Label").text, "5")
    assert_eq(tile.value, 5)

    gut.p("Testing for value 0")
    tile.value = 0
    assert_eq(tile.get_node("MarginContainer/Label").text, "0")
    assert_eq(tile.value, 0)

    tile.free()

func test_possible_value():
    var tile := tile_scn.instantiate() as SudokuTile
    gut.p("Testing for possible value")
    get_tree().root.add_child(tile)
    assert_eq(tile.possible_values.size(), 9)

    tile.set_impossible(7)
    assert_eq(tile.possible_values.size(), 8)
    assert_eq(tile.possible_values.has(7), false)

    tile.set_possible(7)
    assert_eq(tile.possible_values.size(), 9)
    assert_eq(tile.possible_values.has(7), true)

    tile.free()
