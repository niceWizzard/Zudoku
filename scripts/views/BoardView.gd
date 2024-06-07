extends Control
class_name BoardView

var board : Board


@export var grid : GridContainer

var tileViewsMap := {}
var peerActivatedTileViews : Array[TileView] = []

var activeTileView : TileView = null:
	set(v):
		if activeTileView != null:
			activeTileView.mode_normal()
		activeTileView = v
		activeTileView.mode_selected()
		for peer : TileView in peerActivatedTileViews:
			peer.mode_normal()
		peerActivatedTileViews.clear()

		for coord : Vector2i in board.get_peers(v.coordinate):
			var peerTileView := tileViewsMap[coord] as TileView
			peerTileView.mode_peer_selected()
			peerActivatedTileViews.append(peerTileView)


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
		tileView.mode_normal()


func _ready() -> void:
	for mainGridColIndex in grid.get_child_count():
		var tile_group := grid.get_child(mainGridColIndex).get_child(0).get_children()
		for tileGroupIndex in tile_group.size():
			var tile_view := tile_group[tileGroupIndex]
			var x := (mainGridColIndex %3) * 3 + (tileGroupIndex % 3)
			var y := (mainGridColIndex /3) * 3 + (tileGroupIndex / 3)
			tileViewsMap[Vector2i(x, y)] = tile_view
		
func _on_tile_selected(tile : TileView) -> void:
	activeTileView = tile
