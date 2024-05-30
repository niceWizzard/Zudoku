extends PanelContainer
class_name SudokuTile

@export var label : Label

var possible_values := PackedInt32Array()

var coordinate := Vector2i()


func _ready() -> void:
	reset()

var value : int = 0:
	set(v):
		if v < 0 or v > 9:
			push_error("Value must be between 0 and 9")
		if v != 0:
			label.text = str(v)
		value = v

func is_set() -> bool:
	return value != 0

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
	value = 0
	label.text = ""
	for i in range(1, 10):
		possible_values.push_back(i)
