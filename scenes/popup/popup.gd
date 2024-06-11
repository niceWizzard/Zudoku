extends Control
class_name RPopup

var content_root : Control
var backdrop : Control

var tween : Tween

func _ready() -> void:
	backdrop = get_child(0)
	content_root = get_child(1).get_child(0).get_child(0)
	var content := get_child(2)
	remove_child(content)
	content_root.add_child(content)
	_close()

	

func calculate_content_pivot() -> void:
	content_root.pivot_offset = content_root.size / 2.0


func _on_gui_input(event:InputEvent) -> void:
	if event is InputEventMouse:
		if event.is_pressed():
			close_popup()

func show_popup() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	if tween :
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel()
	tween.tween_property(content_root, "scale", Vector2.ONE, .2).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(content_root, "modulate:a", 1, .2)
	tween.tween_property(backdrop, "modulate:a", 1, .2)

	

func close_popup() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	if tween :
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel()
	tween.tween_property(content_root, "scale", Vector2.ZERO, .2)
	tween.tween_property(backdrop, "modulate:a", 0, .2)
	tween.tween_property(content_root, "modulate:a", 0, .2)

func _close() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	content_root.scale *= 0
	backdrop.modulate.a *= 0
	content_root.modulate.a *= 0
	

func _unhandled_key_input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		close_popup()


func _on_content_resized() -> void:
	calculate_content_pivot()
