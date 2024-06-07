extends Node

signal generate_puzzle_completed(board : Board)

var board : Board

enum Difficulty {
	Noob,
	Basic,
	Easy,
	Normal,
	Hard,
	Expert,
	Master,
	Insane,
}

var puzzle_generated := false

var running_threads := {}
var running_timeouts := {}

func start_timer() -> void:
	var id := str(Time.get_unix_time_from_system(), randi())
	running_timeouts[id] = true
	var timer := get_tree().create_timer(7.0, true, false, true)
	await timer.timeout
	if not running_threads.has(id):
		return
	running_timeouts.erase(id)
	print("Puzzle generation over time!")
	if not puzzle_generated:
		running_threads.clear()
		SceneManager.go_to_start_scn()
		

func generate_puzzle(difficulty : Difficulty) -> Signal:
	puzzle_generated = false
	start_timer()
	for i in range(3):
		var thread := Thread.new()
		thread.start(
			func() -> void:
				var b := Board.generate_puzzle(
					get_tile_from_difficulty(difficulty)
				)	
				if not running_threads.has(thread.get_id()):
					return
				if puzzle_generated:
					running_threads.erase(thread.get_id())
					return
				puzzle_generated = true
				emit_signal.call_deferred(generate_puzzle_completed.get_name(), b)
				running_threads.erase(thread.get_id())

		)
		running_threads[thread.get_id()] = thread
	
	return generate_puzzle_completed

func _exit_tree() -> void:
	running_threads.clear()

func get_tile_from_difficulty(difficulty: Difficulty) -> int:
	
	match difficulty:
		Difficulty.Noob:
			return 71
		Difficulty.Basic:
			return 66
		Difficulty.Easy:
			return 56
		Difficulty.Normal:
			return 46
		Difficulty.Hard: 
			return 36
		Difficulty.Expert:
			return 30
		Difficulty.Master:
			return 24
		Difficulty.Insane:
			return 17
		_:
			return 40

