extends Node2D

@export var main_grid: GridContainer

static var possible_values := range(1,10)
static var tile_view_map := TileViewMap.new()

func _ready():
	# Get all the tileviews
	var main_grid_c := main_grid.get_children()
	for main_grid_col in main_grid_c.size():
		var tile_group := main_grid_c[main_grid_col].get_children()
		for tile_group_index in tile_group.size():
			var tile_view := tile_group[tile_group_index]
			var x := (main_grid_col % 3)*3 + (tile_group_index % 3)
			var y := (main_grid_col / 3)*3 + ( tile_group_index / 3)
			tile_view_map.put(x,y, tile_view)
		
	for y in range(9):
		for x in range(9):
			var tile_view := tile_view_map.get_tile(x,y)
			tile_view.value = possible_values.pick_random()

