extends PanelContainer
class_name TileView

@export var _label : Label

var coordinate : Vector2i

func setup(coord : Vector2i) -> void:
	self.coordinate = coord


func update_view(val : int) -> void:
	_label.text = str(val) if val != 0 else ""

func reset() -> void:
	_label.text = ""