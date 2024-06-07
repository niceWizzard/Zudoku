extends PanelContainer
class_name TileView

signal tile_selected(tile : TileView)

@export var label : Label

var coordinate : Vector2


func setup(coord : Vector2i) -> void:
	coordinate  =coord
	label = get_node("Label")
	gui_input.connect(_on_gui_input)
	

func mode_normal() -> void: 
	pass

func mode_selected() -> void:
	pass

func mode_peer_selected() -> void:
	pass

func update_view(val : int) -> void:
	label.text = str(val if val != 0 else "")

func _on_gui_input(event : InputEvent) -> void:
	if  event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			tile_selected.emit(self)


