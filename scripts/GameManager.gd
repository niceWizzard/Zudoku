extends Node

signal generate_puzzle_completed(board : Board)

var board : Board

var thread : Thread

enum Difficulty {
	VeryEasy,
	Easy,
	Medium,
	Hard,
	VeryHard,
	Nightmare
}

func generate_puzzle(difficulty : Difficulty) -> Signal:
	if thread != null:
		thread.wait_to_finish()
	thread = Thread.new()
	thread.start(
		func() -> void:
			var b := Board.generate_puzzle(
				get_tile_from_difficulty(difficulty)
			)	
			emit_signal.call_deferred(generate_puzzle_completed.get_name(), b)
	)
	
	return generate_puzzle_completed

func _exit_tree() -> void:
	if thread != null:
		thread.wait_to_finish()

func get_tile_from_difficulty(difficulty: Difficulty) -> int:
	
	match difficulty:
		Difficulty.VeryEasy:
			return 60
		Difficulty.Easy:
			return 50
		Difficulty.Medium:
			return 36
		Difficulty.Hard: 
			return 30
		Difficulty.VeryHard:
			return 24
		Difficulty.Nightmare:
			return 17
		_:
			return 40

