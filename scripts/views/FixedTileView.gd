class_name FixedTileView
extends TileView

const prefix := "TileStatic"

func mode_normal() -> void: 
    theme_type_variation = "%s" %prefix

func mode_selected() -> void:
    theme_type_variation = "%sSelected" %prefix

func mode_peer_selected() -> void:
    theme_type_variation = "%sPeerSelected" % prefix

