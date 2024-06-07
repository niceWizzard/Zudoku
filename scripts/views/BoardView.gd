extends Control
class_name BoardView

var board : Board


@export var grid : GridContainer

var tileViewsMap := {}

func set_board(b : Board) -> void:
	board = b
	for key : Vector2i in board.board_map:
		var value := board.board_map[key] as int
		var script := NormalTileView if value == 0 else FixedTileView
		var unsetTileView :=  tileViewsMap[key] as Control
		unsetTileView.set_script(script)
		var tileView := unsetTileView as TileView
		tileView.setup(key)
		tileView.update_view(value)
		tileView.tile_selected.connect(_on_tile_selected)


func _ready() -> void:
	for mainGridColIndex in grid.get_child_count():
		var tile_group := grid.get_child(mainGridColIndex).get_child(0).get_children()
		for tileGroupIndex in tile_group.size():
			var tile_view := tile_group[tileGroupIndex]
			var x := (mainGridColIndex %3) * 3 + (tileGroupIndex % 3)
			var y := (mainGridColIndex /3) * 3 + (tileGroupIndex / 3)
			tileViewsMap[Vector2i(x, y)] = tile_view
			tile_view.get_node("Label").text = str(x,y)
		
func _on_tile_selected(tile : TileView) -> void:
	print("Tile selected: ", tile.coordinate)