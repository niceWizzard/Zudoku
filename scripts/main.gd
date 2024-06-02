extends Node2D

@export var board_view : BoardView

func _ready() -> void:
	await get_tree().physics_frame
	var loop:= true
	await get_tree().create_timer(2.0).timeout
	while loop:
		board_view.board = Board.generate_puzzle()
		await board_view.reflect_changes()
		board_view.board.solve(Vector2i())
		await get_tree().create_timer(10.0).timeout
		await board_view.reflect_changes()
		await get_tree().create_timer(10.0).timeout
		board_view.board.reset()
		await board_view.reflect_changes()
		
