extends Panel
class_name RPopup

var content_root : Control


func _ready() -> void:
	content_root = get_child(0).get_child(0)
	var content := get_child(1)
	print(content_root)
	remove_child(content)
	content_root.add_child(content)
	close_popup()


func _on_gui_input(event:InputEvent) -> void:
	if event is InputEventMouse:
		if event.is_pressed():
			close_popup()

func show_popup() -> void:
	show()
	mouse_filter = Control.MOUSE_FILTER_STOP

func close_popup() -> void:
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func _unhandled_key_input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		close_popup()
