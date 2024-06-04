class_name IntBindable
extends Bindable

var value : int:
    set(val):
        value = val
        _reflect_to_bindings(val)


func _init(initial_value := 0) -> void:
    value = initial_value










