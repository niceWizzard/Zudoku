extends Node2D

@export var board_view : BoardView
@export var lives_label : Label
@export var number_btn_parent : Container
@export var clear_btn : Button
@export var time_label : Label
@export var diff_label : Label

@export_category("Popup")
@export var popup : RPopup
@export var popup_title : Label
@export var popup_desc : Label
@export var retry_btn : Button


var time := 0.0
var lives := IntBindable.new(3)

var orig_board : Board

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
				var count :int= 9 - board_view.valueTileMapping[i].size()
				var btn : Button= number_btn_parent.get_child(i-1)
				if count <= 0:
					btn.disabled = true
					btn.modulate.a = 0
				else:
					btn.disabled = false
					btn.modulate.a = 1
				btn.get_node("Label").text = str(count)
	)	
	load_game()
	while true:
		await get_tree().create_timer(1.0/12.0).timeout
		time_label.text = parse_time(floori(time))

func _onNumberBtnPressed(btn : Button) -> void:
		save_game()
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
				
func disable_buttons() -> void:
	clear_btn.disabled = true
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

func clean_up() -> void:
	set_physics_process(false)
	disable_buttons()
	GameManager.saved_game = ""

func game_won() -> void:
	clean_up()
	popup.show_popup()
	popup_title.text = "You solved it!"
	popup_desc.text = "That puzzle took you %s. Amazing!" % parse_time(floori(time))
	retry_btn.text = "New Game"

func game_lost() -> void:
	clean_up()
	popup.show_popup()
	popup_title.text = "You lost!"
	popup_desc.text = "You ran out of lives. Better luck next time!"
	retry_btn.text = "Try again"

func _on_clear_btn_pressed() -> void:
	board_view.clear_active_tile_value()


func _on_back_btn_pressed() -> void:
	save_game()
	SceneManager.go_to_start_scn()



func _on_main_menu_btn_pressed() -> void:
	SceneManager.go_to_start_scn()


func _on_retry_btn_pressed() -> void:
	if lives.value <= 0:
		GameManager.saved_game = ""
		GameManager.board = orig_board.copy()
		get_tree().reload_current_scene()
	else:
		SceneManager.go_to_game_preloader_scn()

func load_game() -> void:

	if GameManager.saved_game:
		var saved_game : Dictionary = JSON.parse_string(GameManager.saved_game)
		var b := Board.create_from(saved_game["puzzle"])
		board_view.set_board(b)
		orig_board = b.copy()
		time = saved_game['time']
		lives.value = saved_game["lives_left"]
		for key: String in saved_game["state"].keys():
			var value : int = saved_game["state"][key]
			var coord := str_to_var(key) as Vector2i
			var tile := board_view.tileViewsMap[coord] as TileView
			board_view.board.set_tile(coord, value)
			board_view.tileViewsMap[coord].update_view(value)
			board_view.valueTileMapping[0].erase(coord)
			board_view.valueTileMapping[value][coord] = tile
		board_view.tileValueCountChanged.emit()

	else:
		board_view.set_board(GameManager.board)
		orig_board = GameManager.board.copy()
		save_game()
	diff_label.text = GameManager.Difficulty.find_key(Startup.difficulty.value)

func save_game() -> void:
	if lives.value <= 0:
		return 
	var save := {
		"difficulty": GameManager.Difficulty.find_key(Startup.difficulty.value),
		"lives_left" : lives.value,
		"time" : time,
		"puzzle" : orig_board.to_save_string(),
		"state" : board_view.get_board_state()
	}
	GameManager.saved_game = JSON.stringify(save)
