extends Node2D

@export var board_view : BoardView
@export var state_label : Label
@export var number_btn_parent : Container

func _ready() -> void:

	for child : Button in number_btn_parent.get_children():
		child.disabled = true
		board_view.on_active_tile_change.connect(
			func(_a : Vector2i) -> void:
				child.disabled = false
		)
		child.pressed.connect(
			func() -> void:
				board_view.set_active_tile(int(child.text))
		)

		
