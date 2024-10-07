class_name GameLogic
extends Node

@export var highlight: PackedScene
@export var ani_piece: PackedScene

const ORANGE = 1
const PURPLE = 2

#####SET LOCAL PLAYER===========================####
var p1 := PURPLE #Local Player
var p2 := ORANGE #Remote Player

@onready var grid_map: GridMap = $"../GridMap"
@onready var scoreboard: Node3D = $"../Scoreboard"
@onready var piece_spawner: Node3D = $PieceSpawner


#var current_cell: Vector3i

# find and highlight each white piece. Probably temporary.
func show_white() -> void:
	for i in grid_map.get_used_cells_by_item(1):
		var hilite_space = grid_map.map_to_local(i)
		var new_hilite = highlight.instantiate()
		new_hilite.position = hilite_space
		add_child(new_hilite)


#********NOT WORKING***********************************************************
func check_possible():
	
	var is_possible: Array = []
	for i in grid_map.get_used_cells_by_item(p2):
		
		var check_direction: Array[Vector3i] = [
		Vector3i(1, 0, 0),
		Vector3i(1, 0, 1),
		Vector3i(0, 0, 1),
		Vector3i(-1, 0, 1),
		Vector3i(-1, 0, 0),
		Vector3i(-1, 0, -1),
		Vector3i(0, 0, -1),
		Vector3i(1, 0, -1),
		]
		
		for cell in check_direction:
			if grid_map.get_cell_item(i + cell) == p1: 
				if grid_map.get_cell_item(i - cell) == 0:
					var possible_space = (i - cell)
					#place_hilites(hilite_space)
					#test = hilite_space
					
					is_possible.append(i - cell)
	#print(is_possible)
		
		#for cell in check_direction:
			#if grid_map.get_cell_item(i + cell) == p1: 
				#if grid_map.get_cell_item(i - cell) == 0:
					#var possible_space = grid_map.map_to_local(i - cell)
					##place_hilites(hilite_space)
					##test = hilite_space
					#
					#is_possible.append(grid_map.map_to_local(i - cell))
	#print(is_possible)
	return is_possible


#
#woriginal code
		##check direct neighbors
		#if grid_map.get_cell_item(i + Vector3i(1, 0, 0)) == p1: 
			#if grid_map.get_cell_item(i + Vector3i(-1, 0, 0)) == 0:
				#var hilite_space = grid_map.map_to_local(i + Vector3i(-1, 0, 0))
				#place_hilite(hilite_space)

#### CALL TO PLACE A PIECE ===============================####
func flip_check(cell):
	var chk_num = 1
	var to_flip: Array = [] 
	var check_direction: Array[Vector3i] = [
		Vector3i(chk_num, 0, 0),
		Vector3i(chk_num, 0, chk_num),
		Vector3i(0, 0, chk_num),
		Vector3i(-chk_num, 0, chk_num),
		Vector3i(-chk_num, 0, 0),
		Vector3i(-chk_num, 0, -chk_num),
		Vector3i(0, 0, -chk_num),
		Vector3i(chk_num, 0, -chk_num),
	]
	if grid_map.get_cell_item(cell) == 0:
		var is_flipped = false
		for space in check_direction:

			
				var chkcl = cell
				for num in 7:
					var can_place = false
					#if neighbor is other remote player's, write cell to array, set self as
					# check cell and check neighbor
					if grid_map.get_cell_item(chkcl + space) == p2: 
							to_flip.append(chkcl + space)
							#flip_cell(cell + Vector3i(1, 0, 0))
							scoreboard.debug_label.text = str(chkcl) + "	" + str(space)
							chkcl  += space
							can_place = true
				#if neighbor is mine, flip cells in array and clear list
					if grid_map.get_cell_item(chkcl + space) == p1:
						if can_place == true:
							if is_flipped == false:
								set_cell(cell)
								is_flipped = true
							await get_tree().create_timer(0.05).timeout
						#flip_cell(chkcl)
						#await get_tree().create_timer(0.1).timeout
						for sp in to_flip:
							await get_tree().create_timer(0.5).timeout
							flip_cell(sp, check_direction.find(space))
						to_flip = []
						scoreboard.debug_label.text = str(to_flip)
					#if neighbor is empty, clear list and do nothing
					if grid_map.get_cell_item(chkcl + space) == 0:
						to_flip = []
						scoreboard.debug_label.text = str(to_flip)
		scoreboard.update()
		
	#if grid_map.get_cell_item(cell + Vector3i(1, 0, 0)) == p2: 
			#if grid_map.get_cell_item(cell + Vector3i(2, 0, 0)) == p1:
				#flip_cell(cell + Vector3i(1, 0, 0))
	#
	#for c in check_direction:
		##scoreboard.debug_label.text = str(cell)
		#if grid_map.get_cell_item(c + cell) == p2:
			##if grid_map.get_cell_item(c + (cell + cell)) == 0:
				##return
			#if grid_map.get_cell_item(c + (cell + cell)) == p1:
				#flip_cell(c + cell) 
		#


func flip_cell(cell, dir):
	if grid_map.get_cell_item(cell) == p2: 
		#piece_spawner.spawn_piece(cell, p1)
		grid_map.set_cell_item(cell, 0)
		spawn_piece(cell, p1, 1, dir)
		await get_tree().create_timer(1).timeout
		grid_map.set_cell_item(cell, p1) 
		scoreboard.debug_label.text = str(dir)
		scoreboard.update()

func set_cell(cell):
	#piece_spawner.spawn_piece(cell, p1)
	spawn_piece(cell, p1, 0, 0)
	await get_tree().create_timer(1).timeout
	grid_map.set_cell_item(cell, p1)
	scoreboard.update()

func place_hilites(space):
	var new_hilite = highlight.instantiate()
	new_hilite.position = grid_map.map_to_local(space)
	add_child(new_hilite)
		

func delete_hilites():
	for i in get_tree().get_nodes_in_group("highlight"):
		i.queue_free()
		

func spawn_piece(cell, val, ani, dir):
	var new_piece = ani_piece.instantiate()
	#new_piece.top_level = true
	new_piece.position = grid_map.map_to_local(cell)
	##Set Rotation
	if dir == 0:
		new_piece.rotation.y = deg_to_rad(180)
	if dir == 1:
		new_piece.rotation.y = deg_to_rad(135)
	if dir == 2:
		new_piece.rotation.y = deg_to_rad(90)
	if dir == 3:
		new_piece.rotation.y = deg_to_rad(45)
	if dir == 5:
		new_piece.rotation.y = deg_to_rad(-45)
	if dir == 6:
		new_piece.rotation.y = deg_to_rad(-90)
	if dir == 7:
		new_piece.rotation.y = deg_to_rad(-135)
	
	add_child(new_piece)
	if p1 == 1:
		if ani == 0:
			new_piece.animation_player.play("SpawnWhite")
		if ani == 1:
			new_piece.animation_player.play("FlipBlack")
	
	if p1 == 2:
		if ani == 0:
			new_piece.animation_player.play("SpawnBlack")
		if ani == 1:
			new_piece.animation_player.play("FlipWhite")
	await  get_tree().create_timer(1).timeout
	new_piece.queue_free()
	
	
	
	#################################################
	#var new_piece = ani_piece.instantiate()
	##new_piece.top_level = true
	#new_piece.position = grid_map.map_to_local(cell)
	#if grid_map.get_cell_item(cell) == 0:
		#if val == 2:
			#new_piece.animation = 0
		#if val == 1:
			#new_piece.animation = 1
	#
	#if grid_map.get_cell_item(cell) != 0:
		#grid_map.set_cell_item(cell, 0) 
		#if val == 2:
			#new_piece.animation = 2
		#if val == 1:
			#new_piece.animation = 3
	#add_child(new_piece)
	##################################################
