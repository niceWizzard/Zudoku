extends RefCounted
class_name Bindable


var binded_nodes : Array[Array] = []


func _reflect_to_bindings(value : Variant) -> void:
	for a : Array in binded_nodes:
		var object := a[0] as Node
		var property := a[1] as String
		if a.size() == 3:
			var transformer := a[2] as Callable
			object.set(property, transformer.call(value))
		else:
			object.set(property, value)
	
func bind(object:  Node,  property :String) -> void:
	var a  := [object, property]
	binded_nodes.push_back(a)

func bind_transform(object:  Node,  property :String, transformer :Callable) -> void:
	var a  := [object, property, transformer]
	binded_nodes.push_back(a)


func _default_transformer(a : int) -> Variant:
	return a
