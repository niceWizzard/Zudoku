extends GutTest

var board_scn := preload("uid://cv4xo6ygesr5u")

var board : SudokuBoard 
var solver : SudokuSolver

func before_all() -> void:
    board = board_scn.instantiate()
    solver = SudokuSolver.new(board)
    get_tree().root.add_child(board)
    await wait_frames(3)

func after_all() -> void:
    board.queue_free()
    
func test_generate() -> void:
    gut.p("Testing board generation 10x")
    for i in range(10):
        board.reset()
        solver.generate_board()
        for y in range(9):
            for x in range(9):
                var v := board.get_tile(x, y).value
                assert_true(verify_col(x,y, v), "Tile (%s, %s) has duplicate value in col" % [x,y])
                assert_true(verify_row(x,y, v), "Tile (%s, %s) has duplicate value in row" % [x,y])
                assert_true(verify_group(x,y, v), "Tile (%s, %s) has duplicate value in group" % [x,y])


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
