extends Control
class_name BoardView

signal tileValueCountChanged

var board : Board


@export var grid : GridContainer

var tileViewsMap := {}
var peerActivatedTileViews : Array[TileView] = []

var activeTileView : TileView = null
var unfilled_tiles : int:
	get:
		return valueTileMapping[0].size()

var highlighted_tiles : Array[TileView] = []

var valueTileMapping := {}

func get_active_tile_value() -> int:
	if activeTileView == null:
		return -1
	return board.get_tile(activeTileView.coordinate)

func set_active_tile_value(val : int) -> void:
	board.set_tile(activeTileView.coordinate, val)

func set_board(b : Board) -> void:
	board = b
	for key : Vector2i in board.board_map:
		var value := board.board_map[key] as int
		var unsetTileView :=  tileViewsMap[key] as Control
		unsetTileView.set_script(TileView)
		var tileView :TileView = unsetTileView
		tileView.setup(key)
		if value != 0:
			tileView.fixed()
		tileView.update_view(value)
		tileView.tile_selected.connect(_on_tile_selected)
		tileView.mode_normal()

		var valueTileDict := valueTileMapping[value] as Dictionary
		valueTileDict[key] = tileView
	tileValueCountChanged.emit()


func _ready() -> void:
	for i in range(10):
		valueTileMapping[i] = {}
	for mainGridColIndex in grid.get_child_count():
		var tile_group := grid.get_child(mainGridColIndex).get_child(0).get_children()
		for tileGroupIndex in tile_group.size():
			var tile_view := tile_group[tileGroupIndex]
			var x := (mainGridColIndex %3) * 3 + (tileGroupIndex % 3)
			var y := (mainGridColIndex /3) * 3 + (tileGroupIndex / 3)
			tileViewsMap[Vector2i(x, y)] = tile_view
		
func _on_tile_selected(tile : TileView) -> void:
	for peer : TileView in peerActivatedTileViews:
			peer.mode_normal()
	if activeTileView != null:
		activeTileView.mode_normal()
	activeTileView = tile
	activeTileView.mode_selected()

	peerActivatedTileViews.clear()

	for coord : Vector2i in board.get_peers(tile.coordinate):
		var peerTileView := tileViewsMap[coord] as TileView
		peerTileView.mode_peer_selected()
		peerActivatedTileViews.append(peerTileView)
	
	for i : TileView in highlighted_tiles:
		i.clear_highlight()

	if activeTileView.is_fixed():
		for i : TileView in valueTileMapping[get_active_tile_value()].values():
			if i == activeTileView:
				continue
			i.highlight_peer()
			highlighted_tiles.append(i)
	
func try_set_active_tile_value(value : int) -> bool:
	if activeTileView == null:
		return false
	if not board.is_valid_for_tile(activeTileView.coordinate, value):
		return false
	var prevValue := get_active_tile_value()
	set_active_tile_value(value)
	activeTileView.update_view(value)

	update_active_tile_tile_count(prevValue)
	return true

	 
func clear_active_tile_value() -> void:
	if activeTileView == null:
		return
	if activeTileView.is_fixed():
		return
	var prevValue :=  get_active_tile_value()
	set_active_tile_value(0)
	activeTileView.update_view(0)
	
	update_active_tile_tile_count(prevValue)

func update_active_tile_tile_count(prevValue: int) -> void:
	valueTileMapping[prevValue].erase(activeTileView.coordinate)
	var curValue := board.get_tile(activeTileView.coordinate)
	valueTileMapping[curValue][activeTileView.coordinate] = activeTileView
	tileValueCountChanged.emit()
