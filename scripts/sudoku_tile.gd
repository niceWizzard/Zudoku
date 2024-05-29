extends PanelContainer
class_name SudokuTile

@export var label : Label

var value : int = 0:
	set(v):
		if v < 1 or v > 9:
			push_error("Value must be between 1 and 9")
		label.text = str(v)
		value = v