extends Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	
	body.queue_free()
	
	$HitSound.transform = $Area3D.transform
	$HitSound.play()
	
	$Area3D.transform.origin = Vector3(randf_range(-1.0, 1.0), randf_range(-0.5, 0.5), 0.0)
