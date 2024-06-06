extends Button
class_name TileView

signal tile_activated(coordinate : Vector2i)

var coordinate : Vector2i

enum State {
	DEFAULT,
	STATIC,
}

var state := State.DEFAULT:
	set(v):
		state = v
		if state == State.STATIC:
			self.mouse_filter = MOUSE_FILTER_IGNORE
			self.focus_mode = FOCUS_NONE
			theme_type_variation = "TileStatic"
		else:
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
	if state == State.STATIC:
		return
	tile_activated.emit(coordinate)

func _on_pressed() -> void:
	if state == State.STATIC:
		return
	tile_activated.emit(coordinate)

