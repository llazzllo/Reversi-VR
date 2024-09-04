extends XROrigin3D

var click: bool

@export var gridmap: GridMap

@onready var ray_cast: RayCast3D = $LeftHand/FunctionPointer/RayCast

#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ray_cast.force_raycast_update()
	
	
	
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider is GridMap:
			var collision_point = ray_cast.get_collision_point()
			var cell = gridmap.local_to_map(collision_point)
			
			if gridmap.get_cell_item(cell) == 0:
				if click:
					gridmap.set_cell_item(cell, 2)


func _on_left_hand_button_pressed(name: String) -> void:
	if name == "trigger_click":
		click = true


func _on_left_hand_button_released(name: String) -> void:
	if name == "trigger_click":
		click = false
