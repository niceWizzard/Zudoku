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

