class_name NormalTileView
extends TileView

func mode_normal() -> void: 
    theme_type_variation = "Tile"

func mode_selected() -> void:
    theme_type_variation = "TileSelected"

func mode_peer_selected() -> void:
    theme_type_variation = "TilePeerSelected"
