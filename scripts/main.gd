extends Node2D

@export var board_view : BoardView

# var board : SudokuBoard

func _ready() -> void:
	var board := Board.new()
	var solved:= board.solve(Vector2i(0,0))
	print(solved)
# func _ready() -> void:
# 	await get_tree().physics_frame


# 	var solved := Board.solve(Board.create())
# 	print(solved)

# 	return
# 	board = board_view.board
# 	var solver := SudokuSolver.new(board_view.board)
# 	solver.generate_board()
# 	await board_view.reflect_changes()

# 	var loop:= true
# 	while loop:
# 		board.reset()
# 		await board_view.reflect_changes()
# 		solver.generate_board()
# 		await board_view.reflect_changes()
# 		for y in range(9):
# 			for x in range(9):
# 				if  !verify_col(x, y, board.get_tile(x, y).value) or \
# 					!verify_row(x, y, board.get_tile(x, y).value) or \
# 					!verify_group(x, y, board.get_tile(x, y).value):
# 						print("Failed at ", x, " ", y)
# 						loop = false
# 						break

# func verify_col(x : int, y : int, val: int) -> bool:
# 	for i in range(9):
# 		if i == y:
# 			continue
# 		if board.get_tile(x, i).value == val:
# 			return false
# 	return true

# func verify_row(x : int, y : int, val: int) -> bool:
# 	for i in range(9):
# 		if i == x:
# 			continue
# 		if board.get_tile(i, y).value == val:
# 			return false
# 	return true

# func verify_group(x : int, y : int, val:  int) -> bool:
# 	var group_x := x / 3
# 	var group_y := y / 3
# 	for tile : SudokuTile in board.get_tile_group(group_x, group_y):
# 		if tile.coordinate != Vector2i(x,y) and tile.value == val:
# 			return false
# 	return true
