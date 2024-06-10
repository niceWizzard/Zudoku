extends Node2D

@export var board_view : BoardView
@export var lives_label : Label
@export var number_btn_parent : Container
@export var clear_btn : Button
@export var time_label : Label

@export_category("Popup")
@export var popup : RPopup
@export var popup_title : Label
@export var popup_desc : Label
@export var retry_btn : Button


var time := 0 
var lives := IntBindable.new(3)

func _ready() -> void:
	lives.bind_transform(lives_label, "text", 
		func(a: int) -> String:
			return "Lives left: %s" %a
	)

	for child : Button in number_btn_parent.get_children():
		child.pressed.connect(
			_onNumberBtnPressed.bind(child)
		)
	await get_tree().physics_frame
	board_view.tileValueCountChanged.connect(
		func() -> void:
			for i in range(1, 10):
				number_btn_parent.get_child(i-1).get_node("Label").text = str(9-board_view.valueTileMapping[i].size())
	)	
	board_view.set_board(GameManager.board)

	while true:
		await get_tree().create_timer(1.0/12.0).timeout
		time_label.text = parse_time(time)

func _onNumberBtnPressed(btn : Button) -> void:
		if board_view.activeTileView == null or board_view.activeTileView.is_fixed():
			return
		var can_set :=  board_view.try_set_active_tile_value(int(btn.text))
		if  can_set and board_view.unfilled_tiles == 0 and board_view.board.is_solved():
			game_won()
		elif not can_set:
			board_view.clear_highlighted_tiles()
			for peer : TileView in board_view.get_active_tile_view_peers():
				if peer.value() == int(btn.text):
					peer.highlight_error()
					board_view.highlighted_tiles.append(peer)
			lives.value -= 1
			if lives.value == 0:
				game_lost()
				for c: Button in number_btn_parent.get_children():
					c.disabled = true	

func parse_time(time : int) -> String:
	var seconds := time % 60 
	var minutes := floori(time / 60) % 60
	var hours := floori(time / (60 * 60))
	var s := ""		
	s += ("0%s" if seconds < 10 else "%s") % seconds
	s = ("0%s:" if minutes < 10 else "%s:") % minutes + s
	if hours > 0:
		s = ("0%s:" if hours < 10 else "%s:") % hours + s
	return s 

func _physics_process(delta : float) -> void:
	time += delta


func game_won() -> void:
	popup_title.text = "You solved it!"
	popup_desc.text = "That puzzle took you %s. Amazing!" % parse_time(floori(time))
	retry_btn.text = "New Game"

func game_lost() -> void:
	popup.show_popup()
	popup_title.text = "You lost!"
	popup_desc.text = "You ran out of lives. Better luck next time!"
	retry_btn.text = "Try again"

func _on_clear_btn_pressed() -> void:
	board_view.clear_active_tile_value()


func _on_back_btn_pressed() -> void:
	SceneManager.go_to_start_scn()



func _on_main_menu_btn_pressed() -> void:
	SceneManager.go_to_start_scn()


func _on_retry_btn_pressed() -> void:
	print("RETRY! NOT IMPELEMENTED YET")


