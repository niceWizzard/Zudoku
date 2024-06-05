extends Control

func _ready() -> void:
	var b : Board= await GameManager.generate_puzzle(Startup.difficulty.value)
	GameManager.board = b
	SceneManager.go_to_main_scn()


