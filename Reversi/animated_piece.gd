extends Node3D

@export var animation : int
@onready var animation_player: AnimationPlayer = $AngleControl/AnimationPlayer


## Called when the node enters the scene tree for the first time.
#func play() -> void:
	##animation_player.play("SpawnWhite")
	#if animation == 0:
		#animation_player.play("SpawnBlack")
	#if animation == 1:
		#animation_player.play("SpawnWhite")
	#if animation == 2:
		#animation_player.play("FlipWhite")
	#if animation == 3:
		#animation_player.play("FlipBlack")
	#
	#
	#
		#
