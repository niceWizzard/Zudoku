extends Node2D

@export var main_grid: SudokuBoard

func _ready():
    await get_tree().physics_frame
    var solver := SudokuSolver.new(main_grid)       
    solver.generate_board()

    while true:
        await get_tree().create_timer(1).timeout
        main_grid.reset()
        solver.generate_board()

