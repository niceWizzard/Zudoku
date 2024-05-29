extends GutTest


var board_scn := preload("uid://cv4xo6ygesr5u")
@onready var board := board_scn.instantiate() as SudokuBoard

func before_all():
    get_tree().root.add_child(board)
    wait_seconds(0.01)
    

func test_board_size():
    gut.p("Testing board size")
    assert_eq(board.tile_map.values().size(), 81)

func test_put_tiles():
    var tile := SudokuTile.new()
    board.put_tile(10, 10, tile)
    assert_eq(board.get_tile(10, 10), tile)

    gut.p("Freeing tile")
    tile.free()

func after_all():
    board.free()