extends Button
class_name TileView

signal tile_activated(coordinate : Vector2i)

var coordinate : Vector2i

var is_static := false:
	set(v) :
		is_static = v

enum State {
	DEFAULT,
	ACTIVE,
	PEER_ACTIVE,
	STATIC,
	STATIC_PEER_ACTIVE
}

var state := State.DEFAULT:
	set(v):
		if state == v:
			return
		state = v
		match state:		
			State.STATIC:
				theme_type_variation = "TileStatic"
			State.ACTIVE:
				theme_type_variation = "TileActive"
			State.PEER_ACTIVE:
				theme_type_variation = "TilePeerActive"
			State.STATIC_PEER_ACTIVE:
				theme_type_variation = "TileStaticPeerActive"
			_:
				self.mouse_filter = MOUSE_FILTER_STOP
				self.focus_mode = FOCUS_CLICK
				theme_type_variation = "Tile"



func setup(coord : Vector2i) -> void:
	self.coordinate = coord


func update_view(val : int) -> void:
	text = str(val) if val != 0 else ""

func reset() -> void:
	text = ""

func _on_focus_entered() -> void:
	if is_static:
		return
	tile_activated.emit(coordinate)

func _on_pressed() -> void:
	tile_activated.emit(coordinate)

