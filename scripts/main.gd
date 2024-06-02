extends Node2D

@export var board_view : BoardView
@export var state_label : Label

func _ready() -> void:
	await get_tree().physics_frame
	var loop:= true
	while loop:
		state_label.text = str("Generating puzzle...")
		await get_tree().physics_frame
		var start := Time.get_unix_time_from_system()
		board_view.board = Board.generate_puzzle()
		var end := Time.get_unix_time_from_system() - start
		state_label.text = str("Puzzle generated! Took %sms" % (end * 1000))
		await board_view.reflect_changes()

		state_label.text = str("Solving puzzle...")
		await get_tree().physics_frame

		start = Time.get_unix_time_from_system()
		board_view.board.solve(Vector2i())
		end = Time.get_unix_time_from_system() - start
		
		state_label.text = str("Puzzle solved! Took %sms" % (end * 1000))
		await board_view.reflect_changes()

		for i in range(10):
			state_label.text = str("Restarting in %ss" % (10 - i))
			await get_tree().create_timer(1.0).timeout
		state_label.text = "Clearing the board..."
		board_view.board.reset()
		await board_view.reflect_changes()
		
