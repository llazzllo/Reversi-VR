extends Node3D

@export var gridmap: GridMap

@onready var white_score: Label3D = $WhiteScore
@onready var black_score: Label3D = $BlackScore
@onready var game_over_label: Label3D = $GameOverLabel

@onready var debug_label: Label3D = $DebugLabel


func _ready() -> void:
	update()


func update():
	var wht_sc = gridmap.get_used_cells_by_item(1).size()
	var blk_sc = gridmap.get_used_cells_by_item(2).size()
	
	white_score.text = str(wht_sc)
	black_score.text = str(blk_sc)
	
	if gridmap.get_used_cells_by_item(0).size() == 0:
		game_over_label.visible = true
