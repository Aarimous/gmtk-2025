extends Node2D


@export_range(0.1, 2.0 , .1) var orbit_speed_scale = 1.0

@export var is_clockwise = true


@export var orbit_speed = 0

@export var object_in_orbit : Array[Node2D]


@export var radius_scale = 1.0


var eclipse_a = 1.0
@export var eclipse_b = 1.0

var orbit_speed_base = 20
var radius_base = 300

var a_radius = 0
var b_radius = 0


@export var orbit_offest : Vector2 = Vector2.ZERO

func _ready():
	if is_clockwise == false:
		$AnimationPlayer.play_backwards("Rotate")
		
	$AnimationPlayer.speed_scale = orbit_speed_scale
	
	a_radius = radius_scale * radius_base * eclipse_a
	b_radius = radius_scale * radius_base * eclipse_b
	
	
	
	%OrbitLine.setup(a_radius)
	%OrbitLine.position = orbit_offest
	%OrbitLine.scale = Vector2(eclipse_a, eclipse_b)
	
	orbit_speed = radius_base / a_radius * orbit_speed_base
	orbit_speed *= 1 if is_clockwise else -1
	
	var rand_offset  = deg_to_rad(Global.rng.randi_range(0, 360))
	
	var step = deg_to_rad(360)/object_in_orbit.size()
	
	for i in range( object_in_orbit.size() ):
		object_in_orbit[i].theta = rand_offset + (step * i)


func _physics_process(delta: float) -> void:
	for object in object_in_orbit:
		object.theta += deg_to_rad(orbit_speed) * delta
		object.position = Vector2(a_radius * cos(object.theta), b_radius * sin(object.theta)) + orbit_offest * 2.0
		
	

	
	
	


func _on_child_exiting_tree(node: Node) -> void:
	if node in object_in_orbit:
		object_in_orbit.erase(node)
