extends GridContainer
class_name BoardView

signal on_active_tile_change(coord: Vector2i)

var board := Board.generate_puzzle(
	get_tile_from_difficulty()
)

var active_tile_coord := Vector2i(-1,-1)
var tile_views : Array[TileView] = []
var tile_views_map := {}

func get_tile_from_difficulty() -> int:
	match Startup.difficulty.value:
		0:
			return 60
		1:
			return 40
		2: 
			return 30
		_:
			return 40

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
			tile_view.tile_activated.connect(self._on_tile_activated)
			tile_views_map[Vector2i(x,y)] = tile_view
	for tile_view : TileView in tile_views:
		var val := board.get_tile(tile_view.coordinate)
		if val != 0:
			tile_view.state = TileView.State.STATIC	
		tile_view.update_view(val)

func _on_tile_activated(coord : Vector2i) -> void:
	active_tile_coord = coord
	on_active_tile_change.emit(coord)

func set_active_tile(val : int) -> void:
	if active_tile_coord.x == -1:
		return

	board.set_tile(active_tile_coord, val)	
	var tile_view:=tile_views_map[active_tile_coord] as TileView
	tile_view.update_view(val)

func reflect_changes(animate:=true) -> void:
	tile_views.shuffle()
	for tile_view : TileView in tile_views:
		tile_view.update_view(board.get_tile(tile_view.coordinate))
		if animate:
			await get_tree().create_timer(0.02).timeout
	
func can_set_tile(val : int) -> bool:
	return board.is_valid_for_tile(active_tile_coord,val)