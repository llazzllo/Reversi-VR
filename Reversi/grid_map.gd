extends GridMap

@export var highlight: PackedScene

@onready var scoreboard: Node3D = $"../Scoreboard"
@onready var left_hand: XRController3D = $"../WalkMode/LeftHand"
@onready var ray_cast: RayCast3D = $"../WalkMode/LeftHand/FunctionPointer/RayCast"



func pointer_event(event : XRToolsPointerEvent) -> void:
	# When pressed, randomize the color
	if event.event_type == XRToolsPointerEvent.Type.ENTERED:
		#scoreboard.debug_label.text = "YES" + "   " + str(ray_cast.is_colliding())
		left_hand.trigger_haptic_pulse("haptic", 0.0,0.2, 0.1, 0.0)
		if ray_cast.is_colliding():
			var collider = ray_cast.get_collider()
			if collider is GridMap:
				var collision_point = local_to_map(ray_cast.get_collision_point())
				var new_hilite = highlight.instantiate()
				new_hilite.position = map_to_local(collision_point)
				add_child(new_hilite)



	if event.event_type == XRToolsPointerEvent.Type.EXITED:
		#scoreboard.debug_label.text = "NO"
		for i in get_tree().get_nodes_in_group("highlight"):
			i.queue_free()
		
	
