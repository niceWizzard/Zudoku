extends Node2D

@export var board_view : BoardView
@export var state_label : Label
@export var lives_label : Label
@export var number_btn_parent : Container
@export var clear_btn : Button
@export var time_label : Label

var time := 60.0
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
		await get_tree().physics_frame
		while true:
			await get_tree().create_timer(1.0/12.0).timeout
			time_label.text = parse_time(time)

func parse_time(time : float) -> String:
	var seconds := floori(time) % 60 
	var minutes := floori(time / 60)
	var hours := floori(time / (60 * 60))
	var s := ""		
	var array := []
	if hours != 0:
		s += "%sh "
		array.push_front(hours)
	if minutes != 0:
		s += "%smin "
		array.push_back(minutes)
	s += "%ss"
	array.push_back(seconds)
	return s % array

func _physics_process(delta : float) -> void:
	time += delta

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


func _on_back_button_pressed() -> void:	
	SceneManager.go_to_start_scn()