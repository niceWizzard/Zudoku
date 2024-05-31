extends RefCounted
class_name TilePeersMap

var dict := {}

func put(key : Vector2i, value : Array[Tile]) -> void:
    if dict.has(key):
        push_error("Key already exists in the map: " + str(key))
        return
    dict[key] = value

func get_peers(key : Vector2i) -> Array[Tile]:
    if not dict.has(key):
        push_error("Key not found in the map: " + str(key))
        return []
    return dict[key]

