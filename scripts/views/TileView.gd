extends Button
class_name TileView

signal tile_selected(tile : TileView)

var coordinate : Vector2i

const TILE_THEME := preload("uid://bgd6lt1h1dri")


func setup(coord : Vector2i) -> void:
	coordinate  =coord
	gui_input.connect(_on_gui_input)
	theme = TILE_THEME
	

func mode_normal() -> void: 
	pass

func mode_selected() -> void:
	pass

func mode_peer_selected() -> void:
	pass

func update_view(val : int) -> void:
	text = str(val) if val != 0 else ""

func _on_gui_input(event : InputEvent) -> void:
	if  event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			tile_selected.emit(self)


