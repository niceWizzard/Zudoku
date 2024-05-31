extends GutTest


func test_create() -> void:
    var board := Board.create()
    assert_eq(board.tiles_map.dict.size(), 81, "Board should have 81 tiles")
    assert_eq(board.tile_peers_map.dict.size(), 81, "Board should have 81 tile peers")
    for y in range(9):
        for x in range(9):
            assert_eq(board.tile_peers_map.get_peers(Vector2i(x,y)).size(), 20, "Tile at %s should have 20 peers" % Vector2i(x,y))

func test_copy() -> void:
    var b := Board.create()
    b.get_tile(0,0).assign(1)
    var c := b.copy()
    assert_eq(c.get_tile(0,0).value(), 1, "Copied board should have same value at 0,0")
    assert_eq(c.get_tile(0,0).value(), b.get_tile(0,0).value(), "Copied board should have same tile value at 0,0")

    for y in range(9):
        for x in range(9):
            var coord := Vector2i(x,y)
            assert_eq(c.tile_peers_map.get_peers(coord).size(), b.tile_peers_map.get_peers(coord).size(), "Copied board should have same number of peers at %s" % coord)
            for i in range(c.tile_peers_map.get_peers(coord).size()):
                assert_eq(
                    c.tile_peers_map.get_peers(coord)[i].value(), 
                    b.tile_peers_map.get_peers(coord)[i].value(), 
                    "Copied board should have same peer value at %s" % coord
                )
                assert_false(c.get_tile(x,y) == b.get_tile(x,y), "Copied board should have different tile object (reference) at %s" %coord)

            var copy2 := c.copy()
            var copy3 := c.copy()
            copy3.get_tile(x,y).assign(2)
            assert_false(copy3.get_tile(x,y).value() == copy2.get_tile(x,y).value(), "Copied board should have different tile value at %s" % coord)

                



