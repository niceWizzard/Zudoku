extends GutTest



var orig_list : Array[Tile]

func before_all() -> void:
	for i in range(10):
		orig_list.append(Tile.new(Vector2i(i, i)))

func test_init() -> void:
	var map := TilePeersMap.new()
	assert_eq(map.dict.size(), 0, "Dictionary should be empty at start")

func test_put() -> void:
	var map := TilePeersMap.new()
	var coord := Vector2i()
	map.put(coord, orig_list.duplicate())
	assert_eq(map.dict.size(), 1, "Dictionary should have one element")
	assert_eq(map.dict.has(coord), true, "Dictionary should have the key")
	assert_eq(map.dict[coord], orig_list, "The list should be the same as the original list")
	

func test_get_peers() -> void:
	var map := TilePeersMap.new()
	var coord := Vector2i()
	map.put(coord, orig_list.duplicate())

	var peers := map.get_peers(coord)
	assert_eq(peers, orig_list, "The returned peers should be the same as the original list")


func test_copy() -> void:
	var map := TilePeersMap.new()
	var coord := Vector2i()
	map.put(coord, orig_list.duplicate())

	var copy := map.copy()
	assert_eq(copy.dict.size(), 1, "The copy should have the same size as the original")
	
	assert_false(copy == map, "The copy should not be the same as the original")
	assert_false(copy.dict == map.dict, "The copy's dictionary should not be the equal to the original's dictionary")
	var peers1 := map.get_peers(coord)
	var peers2 := copy.get_peers(coord)
	assert_false(peers1 == peers2, "The peers should not be the equal")
	assert_eq(peers1.size(), peers2.size(), "The peers should have the same size")
	for i in range(peers1.size()):
		assert_false(peers1[i] == peers2[i], "The peer in list should not be equal")
