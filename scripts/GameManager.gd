extends Node

signal generate_puzzle_completed(board : Board)

var board : Board

var thread : Thread


func generate_puzzle(difficulty : int) -> Signal:
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
	thread.wait_to_finish()

func get_tile_from_difficulty(difficulty: int) -> int:
	match difficulty:
		0:
			return 60
		1:
			return 40
		2: 
			return 30
		_:
			return 40

