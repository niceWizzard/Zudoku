extends RefCounted
class_name TilesMap

var dict := {}

func put(key : Vector2i, value : Tile) -> void:
    if dict.has(key):
        push_error("Key already exists in the map: " + str(key))
        return
    dict[key] = value

func get_tile(key : Vector2i) -> Tile:
    if not dict.has(key):
        push_error("Key not found in the map: " + str(key))
        return null
    return dict[key]

func copy() -> TilesMap:
    var t := TilesMap.new()
    for key : Vector2i in self.dict.keys():
        t.put(key, self.dict[key].copy())
    return t