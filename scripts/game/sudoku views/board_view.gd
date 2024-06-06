extends GridContainer
class_name BoardView

signal on_active_tile_change(coord: Vector2i)

var board : Board

var tile_views : Array[TileView] = []
var tile_views_map := {}
var active_tile_view : TileView
var active_tile_peers : Array[TileView]= []

func _ready() -> void:
	board = GameManager.board
	for main_grid_col in get_children().size():
		var tile_group := get_children()[main_grid_col].get_children()[0].get_children()
		for tile_group_index in tile_group.size():
			var tile_view := tile_group[tile_group_index] as TileView
			tile_view.reset()
			var x := (main_grid_col % 3)*3 + (tile_group_index % 3)
			var y := (main_grid_col / 3)*3 + ( tile_group_index / 3)
			tile_view.setup(Vector2i(x,y))
			tile_views.append(tile_view)
			if not tile_view.tile_activated.is_connected(self._on_tile_activated):
				tile_view.tile_activated.connect(self._on_tile_activated)
			tile_views_map[Vector2i(x,y)] = tile_view
	for tile_view : TileView in tile_views:
		var val := board.get_tile(tile_view.coordinate)
		if val != 0:
			tile_view.state = TileView.State.STATIC	
		tile_view.update_view(val)

func _on_tile_activated(coord : Vector2i) -> void:
	if active_tile_view != null:
		active_tile_view.state = TileView.State.DEFAULT

	active_tile_view = tile_views_map[coord] as TileView
	on_active_tile_change.emit(coord)

	active_tile_view.state = TileView.State.ACTIVE
	for i in active_tile_peers:
		if i.state == TileView.State.STATIC_PEER_ACTIVE:
			i.state = TileView.State.STATIC
		else:
			i.state = TileView.State.DEFAULT
	active_tile_peers.clear()

	for peer_coord : Vector2i in board.get_peers(coord):
		var peer := tile_views_map[peer_coord] as TileView
		if peer.state == TileView.State.STATIC:
					peer.state = TileView.State.STATIC_PEER_ACTIVE
		else:
			peer.state = TileView.State.PEER_ACTIVE
		active_tile_peers.append(peer)





func set_active_tile(val : int) -> void:
	if active_tile_view == null:
		return

	board.set_tile(active_tile_view.coordinate, val)	
	active_tile_view.update_view(val)

func reflect_changes(animate:=true) -> void:
	tile_views.shuffle()
	for tile_view : TileView in tile_views:
		tile_view.update_view(board.get_tile(tile_view.coordinate))
		if animate:
			await get_tree().create_timer(0.02).timeout
	
func can_set_tile(val : int) -> bool:
	return board.is_valid_for_tile(active_tile_view.coordinate, val)