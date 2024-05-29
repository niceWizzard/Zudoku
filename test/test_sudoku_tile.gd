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


