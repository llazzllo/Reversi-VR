extends Node3D

@export var ani_piece: PackedScene
@onready var gridmap: GridMap = $"../../GridMap"

func spawn_piece(cell, val):
	var spawn_point = gridmap.map_to_local(cell)
	self.position = spawn_point
	
	var new_piece = ani_piece.instantiate()
	new_piece.top_level = true
	new_piece.position = spawn_point
	if gridmap.get_cell_item(cell) == 0:
		if val == 2:
			new_piece.animation = 0
		if val == 1:
			new_piece.animation = 1
	
	if gridmap.get_cell_item(cell) != 0:
		gridmap.set_cell_item(cell, 0) 
		if val == 2:
			new_piece.animation = 2
		if val == 1:
			new_piece.animation = 3
	add_child(new_piece)
	new_piece.owner = gridmap
