extends PanelContainer
class_name SudokuTile

@export var label : Label

var possible_values := PackedInt32Array()

func _ready():
	for i in range(1, 10):
		possible_values.push_back(i)

var value : int = 0:
	set(v):
		if v < 1 or v > 9:
			push_error("Value must be between 1 and 9")
		label.text = str(v)
		value = v

func set_possible(v : int):
	if possible_values.has(v):
		return
	possible_values.push_back(v)

func set_impossible(v : int):
	if not possible_values.has(v):
		return
	possible_values.remove_at(possible_values.find(v))
	