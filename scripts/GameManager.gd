extends Node

signal generate_puzzle_completed(board : Board)

var board : Board

enum Difficulty {
	VeryEasy,
	Easy,
	Medium,
	Hard,
	VeryHard,
	Nightmare
}

var puzzle_generated := false

var running_threads := {}

func generate_puzzle(difficulty : Difficulty) -> Signal:
	puzzle_generated = false
	for i in range(3):
		var thread := Thread.new()
		running_threads[thread.get_id()] = thread
		thread.start(
			func() -> void:
				var b := Board.generate_puzzle(
					get_tile_from_difficulty(difficulty)
				)	

				if puzzle_generated:
					running_threads.erase(thread.get_id())
					return
				puzzle_generated = true
				emit_signal.call_deferred(generate_puzzle_completed.get_name(), b)
				running_threads.erase(thread.get_id())

		)
	
	return generate_puzzle_completed

func _exit_tree() -> void:
	for thread : Thread in running_threads.values():
		if thread.is_alive():
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

