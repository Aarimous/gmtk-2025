extends Node2D
class_name OrbitLine

var radius

func setup(_radius):
	radius = _radius

func _draw() -> void:
	draw_circle(global_position, radius, Color.WHITE, false, 2, true)
