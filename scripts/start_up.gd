extends Control
class_name Startup

static var difficulty : IntBindable

@export_category("Popup")
@export var popup_root : Control
@export var popup_content : Control

func _ready() -> void:
	difficulty = IntBindable.new(1 if difficulty == null else difficulty.value)
	close_popup()
	for i : String in GameManager.Difficulty.keys():
		var button := Button.new()
		button.text = i
		button.pressed.connect(_on_difficulty_btn_pressed.bind(i))
		popup_content.add_child(button)

func _on_difficulty_btn_pressed(difficulty_name : String) -> void:
	difficulty.value = GameManager.Difficulty[difficulty_name]
	SceneManager.go_to_game_preloader_scn()


func show_popup() -> void:
	popup_root.show()
	popup_root.mouse_filter = Control.MOUSE_FILTER_STOP

func close_popup() -> void:
	popup_root.hide()
	popup_root.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_exit_btn_pressed() -> void:
	get_tree().quit()

func _on_play_btn_pressed() -> void:
	show_popup()

func _unhandled_key_input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		close_popup()

func _on_popup_bg_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			close_popup()