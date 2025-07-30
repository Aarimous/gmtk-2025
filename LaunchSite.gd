extends Area2D
class_name LaunchSite

@export var rocket_packed : PackedScene


#var limit = 300

func _on_mouse_entered() -> void:
	%Art.self_modulate = Color.GREEN


func _on_mouse_exited() -> void:
	%Art.self_modulate = Color.RED
	
	
	
	

var is_grabbed = false :
	set(new_value):
		is_grabbed = new_value
		%"Grabbed Indicator".visible = is_grabbed
		Engine.time_scale = .5 if is_grabbed else 1.0
		

func _process(delta: float) -> void:
	%Line2D.clear_points()
	%TrajectoryLine.clear_points()
	if is_grabbed:
		
		var diff_vec : Vector2 = get_global_mouse_position() - global_position
		var diff_vec_norm = diff_vec.normalized()
		var scalar = min(Global.gravity, diff_vec.length())

		%"Grabbed Indicator".global_position = diff_vec_norm * scalar + global_position
		%Line2D.add_point(Vector2.ZERO)
		%Line2D.add_point(to_local(diff_vec_norm * scalar + global_position))
		update_trajectory(delta)
		
var max_points = 100
func update_trajectory(delta):
	
	var pos = global_position
	var vel = global_position - %"Grabbed Indicator".global_position * 1.5
	for i in max_points:
		%TrajectoryLine.add_point(to_local(pos))
		
		var direction_to_center = pos.normalized()
		vel -= direction_to_center * Global.gravity * delta * 4
		pos += vel * delta * 4
		#if pos.y > $Ground.position.y - 25:
			#break


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("Grab"):
		is_grabbed = true
	if is_grabbed and event.is_action_released("Grab"):
		is_grabbed = false
		launch_rocket()
		
func _input(event: InputEvent) -> void:
	if is_grabbed and event.is_action_released("Grab"):
		is_grabbed = false
		launch_rocket()
		
	
func launch_rocket():
	#var diff_vec : Vector2 = get_global_mouse_position() - global_position
	#var diff_vec_norm = diff_vec.normalized()
	#var scalar = min(limit, diff_vec.length())
	#
	
	var new_rocket : Rocket = rocket_packed.instantiate()
	Global.main.add_child(new_rocket)
	new_rocket.global_position = global_position
	
	var fling_vector = global_position - %"Grabbed Indicator".global_position
	
	new_rocket.fling(fling_vector * 1.5)
	
	
	
