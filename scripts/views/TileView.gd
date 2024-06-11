extends Button
class_name TileView

signal tile_selected(tile : TileView)

var coordinate : Vector2i

const TILE_THEME := preload("uid://bgd6lt1h1dri")
static var SELECTED_TILE_STYLEBOX := preload('uid://drfjk01hda7lm')
static var HIGHLIGHT_ERROR_STYLEBOX := preload('uid://ba1tbkpwdbfqn')

var _is_fixed := false

var stylebox_override := ["normal", "focus", "pressed", "hover"]

func fixed() -> void:
	_is_fixed = true

func is_fixed() -> bool:
	return _is_fixed

func setup(coord : Vector2i) -> void:
	coordinate  =coord
	gui_input.connect(_on_gui_input)
	theme = TILE_THEME

func value() -> int:
	return int(text)

func mode_normal() -> void: 
	var variant := "TileFixed" if _is_fixed else "Tile"
	theme_type_variation = variant

func mode_selected() -> void:
	var variant := "TileFixedSelected" if _is_fixed else "TileSelected"
	theme_type_variation = variant

func mode_peer_selected() -> void:
	var variant := "TileFixedPeerSelected" if _is_fixed else "TilePeerSelected"
	theme_type_variation = variant

func update_view(val : int) -> void:
	text = str(val) if val != 0 else ""

func _on_gui_input(event : InputEvent) -> void:
	if  event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			tile_selected.emit(self)

func highlight_error() -> void:
	for override : String in stylebox_override:
		add_theme_stylebox_override(override, HIGHLIGHT_ERROR_STYLEBOX)


func highlight_peer() -> void:
	for override : String in stylebox_override:
		add_theme_stylebox_override(override, SELECTED_TILE_STYLEBOX)


func clear_highlight() -> void:
	for override : String in stylebox_override:	
		remove_theme_stylebox_override(override)