extends Node3D

@onready var timer: Timer = $TransparencyTimer

var current_transp: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_transparency_timer_timeout() -> void:
	current_transp = self.transparency 
	self.transparency = lerp(current_transp, randf_range(0.0, 0.8), 0.5)
	timer.start()
