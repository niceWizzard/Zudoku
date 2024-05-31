extends GutTest



func test_init() -> void:
	var map := TilesMap.new()
	assert_eq(map.dict.size(), 0, "Dictionary should be empty at start")

func test_put() -> void:
	var map := TilesMap.new()
	var coord := Vector2i()
	map.put(coord, Tile.new(coord))
	assert_eq(map.dict.size(), 1, "Dictionary should have one element")
	assert_eq(map.dict.has(coord), true, "Dictionary should have the key")
	assert_eq(map.dict.get(coord).coordinate, coord, "The value should have the same key")

func test_get_tile() -> void:
	var map := TilesMap.new()
	var coord := Vector2i()
	map.put(coord, Tile.new(coord))
	var tile := map.get_tile(coord)
	assert_eq(tile.coordinate, coord, "The tile should have the same key")
	assert_eq(map.get_tile(coord), tile, "The tile should be the same")


func test_copy() -> void:
	var map := TilesMap.new()
	var coord := Vector2i()
	map.put(coord, Tile.new(coord))
	
	var copy := map.copy()
	assert_eq(copy.dict.size(), 1, "Dictionary should have one element")
	assert_eq(copy.dict.has(coord), true, "Dictionary should have the key")
	assert_eq(copy.get_tile(coord).coordinate, map.get_tile(coord).coordinate, "The map and copy should give the same tile coordinates")

	assert_false(copy.dict == map.dict, "The copy dictionary should be not equal to the original map")
	assert_false(copy == map, "The copy should not be the same as the original map reference")
	assert_false(copy.get_tile(coord) == map.get_tile(coord), "The copy should not have the same tile reference as the original map")
	assert_false(copy.dict[coord] == map.dict[coord], "The copy should not have the same tile reference as the original map")

	
