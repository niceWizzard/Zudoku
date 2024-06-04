extends Control
class_name Startup

@export var difficulty_btn : Button

static var difficulty := IntBindable.new(0)

const MAIN_SCN := preload("uid://kls4jfercssy")

func _ready() -> void:
	difficulty.bind_transform(
		difficulty_btn,
		"text",
		func(a: int) -> String:
			match a:
				0: return "Easy"
				1: return "Medium"
				2: return "Hard"
				_: return "Unknown"
	)

func _on_exit_btn_pressed() -> void:
	get_tree().quit()

func _on_difficulty_btn_pressed() -> void:
	difficulty.value = (difficulty.value + 1 )   % 3


func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_SCN)
 
