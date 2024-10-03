extends Node3D




func _ready() -> void:
	var xr_interface: XRInterface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		var vp: Viewport = get_viewport()
		vp.use_xr = true
	

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_P:
			find_child("NetworkGateway").simple_webrtc_connect("mushroom")
