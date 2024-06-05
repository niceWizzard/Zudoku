extends Node



const START_SCN := preload("uid://dg30cn0wga43j")
const MAIN_SCN := preload("uid://kls4jfercssy")


func go_to_start_scn() -> void:
    get_tree().change_scene_to_packed(START_SCN)

func go_to_main_scn() -> void:
    get_tree().change_scene_to_packed(MAIN_SCN)