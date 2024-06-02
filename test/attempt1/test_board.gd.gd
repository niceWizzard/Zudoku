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