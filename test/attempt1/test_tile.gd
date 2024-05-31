extends GutTest

func test_init() -> void:
    var tile := Tile.new(Vector2i(0,0))
    assert_eq(tile.coordinate, Vector2i(0,0))
    assert_eq(tile.possible_values.size(), 9)
    for i in range(1, 10):
        assert_true(tile.possible_values.has(i))

func test_has_possibility() -> void:
    var tile := Tile.new(Vector2i(0,0))
    for i in range(1, 10):
        assert_true(tile.has_possibility(i))
    assert_false(tile.has_possibility(10))

    gut.p("Removing values")
    for i in range(1,10):
        tile.eliminate_possibility(i)
        assert_false(tile.has_possibility(i))   

func test_eliminate_possibility() -> void:
    var tile := Tile.new(Vector2i(0,0))
    for i in range(1, 10):
        tile.eliminate_possibility(i)
        assert_false(tile.has_possibility(i))
    assert_eq(tile.possible_values.size(), 0)


func test_assign() -> void:
    for i in range(1,10):
        var tile := Tile.new(Vector2i(0,0))
        tile.assign(i)
        assert_eq(tile.possible_values[0], i)
        assert_eq(tile.possible_values.size(), 1)
        for j in range(1, 10):
            if i != j:
                assert_false(tile.has_possibility(j))

func test_value() -> void:
    for i in range(1,10):
        var tile := Tile.new(Vector2i(0,0))
        tile.assign(i)
        assert_eq(tile.value(), i)
        assert_eq(tile.value(), tile.possible_values[0])

func test_copy() -> void:
    var tile := Tile.new(Vector2i(0,0))
    var c := tile.copy()
    assert_eq(tile.coordinate, c.coordinate)
    assert_eq(tile.possible_values.size(), c.possible_values.size())
    for i in range(1, 10):
        assert_eq(tile.has_possibility(i), c.has_possibility(i))
    assert_false(tile == c)

    for i in range(1,10):
        var orig := Tile.new(Vector2i(0,0))
        orig.assign(i)
        var copy := orig.copy()
        assert_eq(orig.value(), copy.value())
        assert_eq(orig.coordinate, copy.coordinate)
        assert_eq(orig.possible_values.size(), copy.possible_values.size())
        assert_false(orig == copy)
