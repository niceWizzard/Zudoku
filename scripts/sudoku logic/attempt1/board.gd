class_name Board
extends RefCounted


var tiles_map := TilesMap.new()
var tile_peers_map := TilePeersMap.new()


static func create() -> Board:
	var b := Board.new()

	for y in range(9):
		for x in range(9):
			var coord := Vector2i(x,y)
			var tile := Tile.new(coord)
			b.tiles_map.put(coord, tile)
	
	for y in range(0,9):
		for x in range(0,9):
			var tile := b.get_tile(x,y)
			var coord := Vector2i(x,y)
			var peers : Array[Tile] = []
			for i in range(0,9):
				# Tiles in the same column
				var same_col := b.get_tile(i,y)
				if !peers.has(same_col) and same_col != tile:
					peers.append(same_col)

				# Tiles in the same row
				var same_row := b.get_tile(x,i)
				if !peers.has(same_row) and same_row != tile:
					peers.append(same_row)
				
				# Tiles in the same 3x3 grid
				var grid_x := (x / 3) * 3 + i % 3
				var grid_y := (y / 3) * 3 + i / 3
				var same_grid := b.get_tile(grid_x,grid_y)
				if !peers.has(same_grid) and same_grid != tile:
					peers.append(same_grid)				
			b.tile_peers_map.put(coord, peers)
	return b


func copy() -> Board:
	var b := Board.new()
	b.tiles_map = tiles_map.copy()

	for y in range(0,9):
		for x in range(0,9):
			var tile := b.get_tile(x,y)
			var coord := Vector2i(x,y)
			var peers : Array[Tile] = []
			for i in range(0,9):
				# Tiles in the same column
				var same_col := b.get_tile(i,y)
				if !peers.has(same_col) and same_col != tile:
					peers.append(same_col)

				# Tiles in the same row
				var same_row := b.get_tile(x,i)
				if !peers.has(same_row) and same_row != tile:
					peers.append(same_row)
				
				# Tiles in the same 3x3 grid
				var grid_x := (x / 3) * 3 + i % 3
				var grid_y := (y / 3) * 3 + i / 3
				var same_grid := b.get_tile(grid_x,grid_y)
				if !peers.has(same_grid) and same_grid != tile:
					peers.append(same_grid)				
			b.tile_peers_map.put(coord, peers)

	return b

func get_tile(x: int, y: int) -> Tile:
	return tiles_map.get_tile(Vector2i(x,y))

func get_tile_group(i : int, j : int) -> Array[Tile]:
	var tile_group : Array[Tile] = []

	for y in range(3):
		for x in range(3):
			tile_group.push_back(get_tile(
				x + 3 * i,
				y + 3 * j
			))

	return tile_group