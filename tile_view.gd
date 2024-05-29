extends PanelContainer
class_name TileView

@export var label : Label

var value : int = 0:
	set(value):
		if value < 1 or value > 9:
			push_error("Value must be between 1 and 9")
		label.text = str(value)