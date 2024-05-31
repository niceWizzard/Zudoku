class_name Tile
extends RefCounted

var coordinate : Vector2i

var possible_values : = PackedInt32Array()

func _init(c : Vector2i) -> void:
    self.coordinate = c
    for i in range(1,10):
        possible_values.push_back(i)

func has_possibility(v : int) -> bool:
    return possible_values.has(v)

func value() -> int:
    return  possible_values[0] if possible_values.size() == 1 else -1

func eliminate_possibility(v : int) -> void:
    var index := possible_values.find(v)
    if index != -1:
        possible_values.remove_at(index)


func assign(v : int) -> void:
    possible_values.clear()
    possible_values.push_back(v)



func copy() -> Tile:
    var new_tile := Tile.new(coordinate)
    new_tile.possible_values = possible_values.duplicate()
    return new_tile


func count_possibilities() -> int:
    return possible_values.size()

func regain_possibility(val : int) -> void:
    if possible_values.has(val):
        push_error("Value already possible.")
        return
    possible_values.append(val)