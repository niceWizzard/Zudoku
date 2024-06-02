extends PanelContainer
class_name TileView

@export var _label : Label

var coordinate : Vector2i
@onready var highlighted_theme := theme.get_stylebox("highlight", "Tile")
@onready var normal_theme := theme.get_stylebox("normal", "Tile")


func _ready() -> void:
	theme = theme.duplicate()

func setup(coord : Vector2i) -> void:
	self.coordinate = coord


func update_view(val : int) -> void:
	_label.text = str(val) if val != 0 else ""

func reset() -> void:
	_label.text = ""

func set_highlighted(is_highlighted: bool) -> void:
	if is_highlighted:
		theme.set_stylebox("panel", "Tile", highlighted_theme)
	else:
		theme.set_stylebox("panel", "Tile", normal_theme)



func _on_mouse_exited() -> void:
	set_highlighted(false)


func _on_mouse_entered() -> void:
	set_highlighted(true)
