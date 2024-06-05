extends RefCounted
class_name Board

var board_map : Dictionary = {}
var peers_map : Dictionary = {}

func copy() -> Board:
	var b := Board.new()
	for key : Vector2i in self.board_map.keys():
		b.board_map[key] = self.board_map[key]
	for key : Vector2i in self.peers_map.keys():
		b.peers_map[key] = self.peers_map[key].duplicate()
	return b

static func generate() -> Board:
	var i:= 0
	while i < 1000:
		var b := Board.new()
		b.fill_independent_groups()
		return b
		if not b.solve():
			i += 1
			continue
		return b
	push_error("Something went wrong and couldn't generate a board")
	return null

static func create_from(puzzle : String) -> Board:
	if puzzle.length() != 81:
		push_error("Invalid puzzle string. It should consist of 81 characters but got %s" % puzzle.length())
		return null
	var b := Board.new()
	var i := -1
	for c : String in puzzle:
		i += 1
		if c == ".":
			continue
		var val := int(c)
		if val <0 or val > 9:
			push_error("Invalid puzzle string")
			return null
		
		var x := i % 9
		var y := i / 9

		b.set_tile(Vector2i(x,y), val)


	return b

static func generate_puzzle(tiles_left := 24) -> Board:
	var b:= generate()
	var limit :int = abs(tiles_left-81)
	var i := 0
	while i < limit: 
		var random := Vector2i(randi_range(0,8), randi_range(0,8))
		if b.get_tile(random) == 0:
			continue
		var orig_val := b.get_tile(random)
		b.set_tile(random, 0)

		if not b.copy().solve():
			b.set_tile(random, orig_val)
			continue
		i += 1
	return b

func fill_independent_groups() -> void:
	for i in range(3):
		var values := range(1, 10)
		values.shuffle()
		var index := 0
		for y in range(3):
			for x in range(3):
				var tile := Vector2i(x + i*3, y + i*3)
				set_tile(tile, values[index])
				index += 1

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

func is_solved() -> bool:
	for y in range(9):
		for x in range(9):
			if get_tilei(x,y) == 0:
				return false
	return true

func solve(tile := Vector2i()) -> bool:
	if tile.y == 9:
		return true

	var next_x := (tile.x + 1) % 9
	var next_y := (tile.y + 1) if tile.x == 8 else tile.y
	var next:= Vector2i(next_x, next_y)

	var tile_val := get_tile(tile)
	if tile_val != 0:
		return solve(next)

	var possible_values := range(1, 10)
	possible_values.shuffle()
	for try_val : int in possible_values:
		if not is_valid_for_tile(tile, try_val):
			continue
		set_tile(tile, try_val)

		if solve(next):
			return true
	
	set_tile(tile, 0)
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

func reset() -> void:
	for y in range(9):
		for x in range(9):
			set_tile(Vector2i(x, y), 0)

func _to_string() -> String:
	var s : = ""
	for y in range(9):
		for x in range(9):
			s += str(get_tile(Vector2i(x, y)), " ")
		s += ("\n")
	return s