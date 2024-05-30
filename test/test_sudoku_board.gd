extends GutTest


var board_scn := preload("uid://cv4xo6ygesr5u")
@onready var board := board_scn.instantiate() as SudokuBoard

func before_all() -> void:
    get_tree().root.add_child(board)
    wait_seconds(0.01)
    

func test_board_size() -> void:
    gut.p("Testing board size")
    assert_eq(board.tile_map.values().size(), 81)

func test_put_tiles() -> void:
    var tile := SudokuTile.new()
    board.put_tile(10, 10, tile)
    assert_eq(board.get_tile(10, 10), tile)

    gut.p("Freeing tile")
    tile.free()

func test_peer_map_size() -> void:
    assert_eq(board.tile_peers_map.size(), 81)
    assert_eq(board.tile_peers_map["1:8"].size(), 20)
    for y in range(9):
        for x in range(9):
            assert_eq(board.tile_peers_map[str(x) + ":" + str(y)].size(), 20)
    

func after_all() -> void:
    board.free()