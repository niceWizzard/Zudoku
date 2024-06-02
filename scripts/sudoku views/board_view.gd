extends GridContainer
class_name BoardView

var board := Board.generate_puzzle()


var tile_views : Array[TileView] = []

func _ready() -> void:
	for main_grid_col in get_children().size():
		var tile_group := get_children()[main_grid_col].get_children()[0].get_children()
		for tile_group_index in tile_group.size():
			var tile_view := tile_group[tile_group_index] as TileView
			tile_view.reset()
			var x := (main_grid_col % 3)*3 + (tile_group_index % 3)
			var y := (main_grid_col / 3)*3 + ( tile_group_index / 3)
			tile_view.setup(Vector2i(x,y))
			tile_views.append(tile_view)
	


func reflect_changes() -> void:
	tile_views.shuffle()
	for tile_view : TileView in tile_views:
		tile_view.update_view(board.get_tile(tile_view.coordinate))
		await get_tree().create_timer(0.02).timeout