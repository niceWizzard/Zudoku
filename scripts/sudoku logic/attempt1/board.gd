extends RefCounted
class_name Board

var board_map : Dictionary = {}
var peers_map : Dictionary = {}

func _init() -> void:
	for y in range(9):
		for x in range(9):
			board_map[Vector2i(x, y)] = 0

	#add peers
	for y in range(9):
		for x in range(9):
			var tile := Vector2i(x, y)
			var peers : = PackedVector2Array()
			for i in range(9):
				var row := Vector2i(x, i)
				if row != tile and not peers.has(row):
					peers.append(row)
				var col := Vector2i(i, y)
				if col != tile and not peers.has(col):
					peers.append(col)

			var x0 := x - x % 3
			var y0 := y - y % 3
			for i in range(3):
				for j in range(3):
					var group := Vector2i(x0 + i, y0 + j)
					if group != tile and not peers.has(group):
						peers.append(group)
			peers_map[tile] = peers


func solve(tile : Vector2i) -> bool:

	var tried_values := PackedInt32Array()
	while true:
		if tried_values.size() == 9:
			return false
		
		var try_val := randi_range(1,9)
		if tried_values.has(try_val):
			continue
		tried_values.append(try_val)

		if not is_valid_for_tile(tile, try_val):
			continue
		
		set_tile(tile, try_val)

		var next_x := (tile.x + 1) % 9
		var next_y := (tile.y + 1) if tile.x == 8 else tile.y
		if solve(Vector2i(next_x, next_y)):
			return true
				
	return false

func is_valid_for_tile(coord : Vector2i, val : int) -> bool:
	for peer : Vector2i in get_peers(coord):
				if get_tile(peer) == val:
					return false
	return true

func set_tile(coord : Vector2i, value : int) -> void:
	board_map[coord] = value


func get_tilei(x : int, y : int) -> int:
	return get_tile(Vector2i(x, y))

func get_peers(coord : Vector2i) -> PackedVector2Array:
	if not peers_map.has(coord):
		return PackedVector2Array()
	return peers_map[coord]

func get_tile(coord : Vector2i) -> int:
	if not board_map.has(coord):
		return -1
	return board_map[coord]


