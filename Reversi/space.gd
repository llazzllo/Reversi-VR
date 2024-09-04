extends MeshInstance3D



# Handle pointer events
func pointer_event(event : XRToolsPointerEvent) -> void:
	# When pressed, randomize the color
	if event.event_type == XRToolsPointerEvent.Type.ENTERED:
		print("I have been entered")
