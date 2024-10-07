extends XROrigin3D


@export var gridmap: GridMap

@onready var ray_cast: RayCast3D = $LeftHand/FunctionPointer/RayCast

#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@rpc("any_peer", "call_local", "reliable", 0)
func Rgridmapsetcell(cell, val):
	gridmap.set_cell_item(cell, val)

func _on_left_hand_button_pressed(name: String) -> void:
	if name == "trigger_click":
		ray_cast.force_raycast_update()
		if ray_cast.is_colliding():
			var collider = ray_cast.get_collider()
			if collider is GridMap:  # == gridmap?
				var collision_point = ray_cast.get_collision_point()
				var cell = gridmap.local_to_map(collision_point)
				var val = 2
				if gridmap.get_cell_item(cell) != 0:
					val = 3 - gridmap.get_cell_item(cell)
				rpc("Rgridmapsetcell", cell, val)

func _on_left_hand_button_released(name: String) -> void:
	if name == "trigger_click":
		pass
		
