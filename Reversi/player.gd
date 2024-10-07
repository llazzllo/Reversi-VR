extends XROrigin3D

var menu_toggle := false 
@export var gridmap: GridMap

@onready var piece_spawner: Node3D = $"../GameLogic/PieceSpawner"

@onready var viewport: Node3D = $"../Viewport2Din3D"
@onready var viewport_light: SpotLight3D = $RightHand/ViewportLight
@onready var ray_cast: RayCast3D = $LeftHand/FunctionPointer/RayCast
@onready var scoreboard: Node3D = $"../Scoreboard"
@onready var game_logic: Node = $"../GameLogic"
@onready var left_hand: XRController3D = $LeftHand




#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



var set_toggle = true


@rpc("any_peer", "call_local", "reliable", 0)
func Rgridmapsetcell(cell, val):
	if set_toggle == true:
		left_hand.trigger_haptic_pulse("haptic", 0.0, 0.3, 0.6, 0.0)
		gridmap.set_cell_item(cell, 0)
		piece_spawner.spawn_piece(cell, val)
		set_toggle = false
		await get_tree().create_timer(1).timeout
		gridmap.set_cell_item(cell, val)
		set_toggle = true

func _on_left_hand_button_pressed(name: String) -> void:
	if name == "trigger_click":
		ray_cast.force_raycast_update()
		if ray_cast.is_colliding():
			var collider = ray_cast.get_collider()
			if collider is GridMap:  # == gridmap? # Yes. -LL
				var collision_point = ray_cast.get_collision_point()
				var cell = gridmap.local_to_map(collision_point)
				
###00000000##  Manual play code ------------------------------------

				#var val = 2
				#if gridmap.get_cell_item(cell) != 0:
					#val = 3 - gridmap.get_cell_item(cell)
				#rpc("Rgridmapsetcell", cell, val)

###XXXXXXXXX## Experimental Code------------------------------------
				scoreboard.debug_label.text = str(cell)
				game_logic.flip_check(cell)
				
				
					
				##printt(cell, game_logic.check_possible())
				#if game_logic.check_possible().has(cell):
					##print("DING!")
					#game_logic.set_cell(cell)
					#game_logic.flip_check(cell)
				##game_logic.flip_check(cell)
				#
###XXXXXXXXX## -----------------------------------------------------
				 

		scoreboard.update()
	
##( @v@ )## Toggle Network Gateway Menu

	if name == "menu_button":
		if menu_toggle == false:
			viewport.visible = true
			viewport_light.visible = true
			menu_toggle = true
		elif menu_toggle == true:
			viewport.visible = false
			viewport_light.visible = false
			menu_toggle = false
	
		#Show/Hide possible moves
	

###XXX### Temporarily Out Of Service 

	if name == "x_button":
		pass
		#game_logic.check_possible()
		#if game_logic.check_possible().size() != 0:
			#for i in game_logic.check_possible():
				#game_logic.place_hilites(i)
		#
		
		
			
func _on_left_hand_button_released(name: String) -> void:
	if name == "x_button":
		pass
#		game_logic.delete_hilites()
	

	if name == "trigger_click":
		pass
		
