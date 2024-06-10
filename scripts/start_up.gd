extends Control
class_name Startup

static var difficulty : IntBindable

@export_category("Popup")
@export var popup : RPopup
@export var popup_content : VBoxContainer

func _ready() -> void:
	difficulty = IntBindable.new(1 if difficulty == null else difficulty.value)
	for i : String in GameManager.Difficulty.keys():
		var button := Button.new()
		button.text = i
		button.pressed.connect(_on_difficulty_btn_pressed.bind(i))
		popup_content.add_child(button)

func _on_difficulty_btn_pressed(difficulty_name : String) -> void:
	difficulty.value = GameManager.Difficulty[difficulty_name]
	SceneManager.go_to_game_preloader_scn()



func _on_exit_btn_pressed() -> void:
	get_tree().quit()

func _on_play_btn_pressed() -> void:
	popup.show_popup()


