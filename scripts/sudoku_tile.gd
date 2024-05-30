extends PanelContainer
class_name SudokuTile

@export var label : Label

var possible_values := PackedInt32Array()

func _ready() -> void:
	reset()

var value : int = 0:
	set(v):
		if v < 1 or v > 9:
			push_error("Value must be between 1 and 9")
		label.text = str(v)
		value = v

func set_possible(v : int) -> void:
	if possible_values.has(v):
		return
	possible_values.push_back(v)

func set_impossible(v : int) -> bool:
	if not possible_values.has(v):
		return true
	possible_values.remove_at(possible_values.find(v))
	return possible_values.size() == 0

func get_random_possible_value() -> int:
	if possible_values.size() == 0:
		return -1
	return possible_values[randi_range(0, possible_values.size()-1)]

func reset() -> void:
	possible_values.clear()
	label.text = "x"
	for i in range(1, 10):
		possible_values.push_back(i)
