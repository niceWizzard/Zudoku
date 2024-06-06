extends Node2D

@export var board_view : BoardView
@export var lives_label : Label
@export var number_btn_parent : Container
@export var clear_btn : Button
@export var time_label : Label

var time := 0.0
var lives := IntBindable.new(3)

func _ready() -> void:
	lives.bind_transform(lives_label, "text", 
		func(a: int) -> String:
			return "Lives left: %s" %a
	)
	clear_btn.disabled = true
	for child : Button in number_btn_parent.get_children():
		child.pressed.connect(
			func() -> void:
				if board_view.can_set_active_tile_value(int(child.text)):
					board_view.set_active_tile_value(int(child.text))
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
		s += "%s:"
		array.push_front(hours)
	if minutes != 0:
		s += "%s:"
		array.push_back(minutes)
	s += "%ss"
	array.push_back(seconds)
	return s % array

func _physics_process(delta : float) -> void:
	time += delta



func _on_clear_btn_pressed() -> void:
	board_view.set_active_tile_value(0)


func _on_back_btn_pressed() -> void:
	SceneManager.go_to_start_scn()
