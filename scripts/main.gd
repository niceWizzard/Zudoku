extends Node2D

@export var main_grid: SudokuBoard

@onready var board := main_grid

func _ready() -> void:
	await get_tree().physics_frame
	var solver := SudokuSolver.new(main_grid)       
	solver.generate_board()

	var loop:= true
	while loop:
		# await get_tree().create_timer(0.1).timeout
		main_grid.reset()
		await solver.generate_board()
		for y in range(9):
			for x in range(9):
				if  !verify_col(x, y, board.get_tile(x, y).value) or \
					!verify_row(x, y, board.get_tile(x, y).value) or \
					!verify_group(x, y, board.get_tile(x, y).value):
						print("Failed at ", x, " ", y)
						loop = false
						break

func verify_col(x : int, y : int, val: int) -> bool:
	for i in range(9):
		if i == y:
			continue
		if board.get_tile(x, i).value == val:
			return false
	return true

func verify_row(x : int, y : int, val: int) -> bool:
	for i in range(9):
		if i == x:
			continue
		if board.get_tile(i, y).value == val:
			return false
	return true

func verify_group(x : int, y : int, val:  int) -> bool:
	var group_x := x / 3
	var group_y := y / 3
	for tile : SudokuTile in board.get_tile_group(group_x, group_y):
		if tile.coordinate != Vector2i(x,y) and tile.value == val:
			return false
	return true
