class_name IntBindable
extends Bindable

var value : int:
    set(val):
        value = val
        _reflect_to_bindings(val)


func _init(initial_value := 0) -> void:
    value = initial_value


func bind(object:  Node,  property :String) -> void:
    super(object, property)
    object.set(property, value)

func bind_transform(object:  Node,  property :String, transformer :Callable) -> void:
    super(object, property, transformer)
    object.set(property, transformer.call(value))







