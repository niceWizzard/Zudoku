extends Node



const START_SCN := preload("uid://dg30cn0wga43j")
const MAIN_SCN := preload("uid://kls4jfercssy")
const GAME_PRELOADER_SCN := preload("uid://cricubqiejveb")

func go_to_start_scn() -> void:
    get_tree().change_scene_to_packed(START_SCN)

func go_to_main_scn() -> void:
    get_tree().change_scene_to_packed(MAIN_SCN)

func go_to_game_preloader_scn() -> void:
    get_tree().change_scene_to_packed(GAME_PRELOADER_SCN)