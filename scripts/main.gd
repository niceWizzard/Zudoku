extends Node2D

@export var board_view : BoardView

func _ready() -> void:
	await get_tree().physics_frame
	var solver := SudokuSolver.new(board_view.board)
	solver.generate_board()
	board_view.reflect_changes()


