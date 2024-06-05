extends MarginContainer
class_name SafeAreaContainer

func _ready() -> void:
	resized.connect(calculate)
	calculate()

func calculate() -> void:
	if not ["android", "ios"].has(OS.get_name().to_lower()):
		return
	var viewSize : Vector2i = get_viewport().size
	var safeArea  := DisplayServer.get_display_safe_area()
	
	add_theme_constant_override("margin_top", safeArea.position.y)
	add_theme_constant_override("margin_left", safeArea.position.x)
	add_theme_constant_override("margin_bottom", viewSize.y-safeArea.end.y)
	add_theme_constant_override("margin_right", viewSize.x-safeArea.end.x)



