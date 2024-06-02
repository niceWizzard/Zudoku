extends Node2D

@export var board_view : BoardView

func _ready() -> void:
	await get_tree().physics_frame
	var board := board_view.board
	var loop:= true
	while loop:
		board.reset()
		await board_view.reflect_changes()
		board.solve(Vector2i())
		await board_view.reflect_changes()
		await get_tree().create_timer(1.0).timeout
