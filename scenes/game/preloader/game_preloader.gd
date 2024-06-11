extends Control

func _ready() -> void:
	GameManager.saved_game = ""
	var b : Board= await GameManager.generate_puzzle(Startup.difficulty.value)
	GameManager.board = b
	SceneManager.go_to_main_scn()


