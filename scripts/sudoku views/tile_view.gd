extends PanelContainer
class_name TileView

@export var _label : Label

var tile : SudokuTile

func setup(t : SudokuTile) -> void:
	self.tile = t


func update_view() -> void:
	_label.text = str(tile.value) if tile.value != 0 else ""

func reset() -> void:
	_label.text = ""