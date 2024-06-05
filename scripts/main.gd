extends Node2D

@export var board_view : BoardView
@export var state_label : Label
@export var lives_label : Label
@export var number_btn_parent : Container
@export var clear_btn : Button

var lives := IntBindable.new(3)

func _ready() -> void:
	lives.bind_transform(lives_label, "text", 
		func(a: int) -> String:
			return "Lives left: %s" %a
	)
	clear_btn.disabled = true
	for child : Button in number_btn_parent.get_children():
		child.disabled = true
		board_view.on_active_tile_change.connect(
			func(_a : Vector2i) -> void:
				clear_btn.disabled = false
				child.disabled = false
		)
		child.pressed.connect(
			func() -> void:
				if board_view.can_set_tile(int(child.text)):
					board_view.set_active_tile(int(child.text))
				else:
					lives.value -= 1
					if lives.value == 0:
						for c: Button in number_btn_parent.get_children():
							c.disabled = true	
		)

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		check()

func check() -> void:
	if board_view.board.is_solved():
			state_label.text = "Solved!"	
	else:
		state_label.text = "Incorrect!"
		


func _on_button_pressed() -> void:
	check()


func _on_clear_btn_pressed() -> void:
	board_view.set_active_tile(0)
