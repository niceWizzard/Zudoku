extends Control
class_name Startup

@export var difficulty_btn : Button

static var difficulty : IntBindable


func _ready() -> void:
	difficulty = IntBindable.new(1 if difficulty == null else difficulty.value)
	difficulty.bind_transform(
		difficulty_btn,
		"text",
		func(a: int) -> String:
			return (GameManager.Difficulty.find_key(a) as String)
	)

func _on_exit_btn_pressed() -> void:
	get_tree().quit()

func _on_difficulty_btn_pressed() -> void:
	difficulty.value = (difficulty.value + 1 )   % GameManager.Difficulty.size()


func _on_play_btn_pressed() -> void:
	SceneManager.go_to_game_preloader_scn()
