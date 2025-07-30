extends Node2D


@export_range(0.1, 2.0 , .1) var orbit_speed_scale = 1.0

@export var is_clockwise = true

func _ready():
	if is_clockwise == false:
		$AnimationPlayer.play_backwards("Rotate")
	$AnimationPlayer.speed_scale = orbit_speed_scale
	
