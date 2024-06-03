extends Button
class_name TileView

var coordinate : Vector2i


func _ready() -> void:
	theme = theme.duplicate()

func setup(coord : Vector2i) -> void:
	self.coordinate = coord


func update_view(val : int) -> void:
	text = str(val) if val != 0 else ""

func reset() -> void:
	text = ""


