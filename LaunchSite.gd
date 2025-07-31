extends Area2D
class_name LaunchSite

@export var rocket_packed : PackedScene


var fling_scale = 2.9
var pull_back_gravity_ratio = .5

var current_rocket : Rocket :
	set(new_value):
		current_rocket = new_value
		loaded = current_rocket == null
		
		


func _on_mouse_entered() -> void:
	if Global.action_state == Global.ACTION_STATE.FREE:
		%Art.scale = Vector2(1.1, 1.1)


func _on_mouse_exited() -> void:
	%Art.scale = Vector2(1, 1)

	
	
var loaded = false:
	set(new_value):
		loaded = new_value
		
		%Art.self_modulate = Color.GREEN if loaded else Color.RED
			
	

var is_grabbed = false :
	set(new_value):
		is_grabbed = new_value
		%"Grabbed Indicator".visible = is_grabbed
		Engine.time_scale = .5 if is_grabbed else 1.0
		

func _ready():
	current_rocket = null
		

func _process(delta: float) -> void:
	%Line2D.clear_points()
	%TrajectoryLine.clear_points()
	if is_grabbed:
		
		var diff_vec : Vector2 =  get_global_mouse_position() - %"Launch Pivot".global_position
		var diff_vec_norm = diff_vec.normalized()
		var scalar = min(Global.gravity * pull_back_gravity_ratio, diff_vec.length())
		var grabber_pos : Vector2 = diff_vec_norm * scalar + %"Launch Pivot".global_position
		
		var angle_to = get_angle_to(grabber_pos)
		
		if rad_to_deg(angle_to) <= 0:
			#print(rad_to_deg(angle_to))	
			if rad_to_deg(angle_to) >= -90:
				grabber_pos = Vector2.RIGHT.rotated(global_rotation) * scalar + %"Launch Pivot".global_position
			else:
				grabber_pos = Vector2.LEFT.rotated(global_rotation) * scalar + %"Launch Pivot".global_position

		%"Grabbed Indicator".global_position = grabber_pos

		
		%Line2D.add_point(%"Launch Pivot".position)
		%Line2D.add_point(to_local(diff_vec_norm * scalar + global_position))
		update_trajectory(delta)
		

func update_trajectory(delta):
	var duration = 2.0
	
	var pos = %"Launch Pivot".global_position
	var vel = (%"Launch Pivot".global_position - %"Grabbed Indicator".global_position) * fling_scale
	while duration > 0:
		%TrajectoryLine.add_point(to_local(pos))
		
		var direction_to_center = pos.normalized()
		vel -= direction_to_center * Global.gravity * delta 
		pos += vel * delta 
		duration -= delta
		#if pos.y > $Ground.position.y - 25:
			#break


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Grab") and loaded == true and Global.action_state == Global.ACTION_STATE.FREE:
		Global.action_state = Global.ACTION_STATE.LAUNCHING_ROCKET
		is_grabbed = true
	if is_grabbed and event.is_action_released("Grab"):
		is_grabbed = false
		Global.action_state = Global.ACTION_STATE.FREE
		launch_rocket()
		
func _input(event: InputEvent) -> void:
	if is_grabbed and event.is_action_released("Grab"):
		is_grabbed = false
		Global.action_state = Global.ACTION_STATE.FREE
		launch_rocket()
	if is_grabbed and event.is_action_released("Cancel"):
		is_grabbed = false
		Global.action_state = Global.ACTION_STATE.FREE
		
	
func launch_rocket():
	#var diff_vec : Vector2 = get_global_mouse_position() - global_position
	#var diff_vec_norm = diff_vec.normalized()
	#var scalar = min(limit, diff_vec.length())
	#

	var new_rocket : Rocket = rocket_packed.instantiate()
	Global.main.add_child(new_rocket)
	current_rocket = new_rocket
	new_rocket.global_position = %"Launch Pivot".global_position
	
	new_rocket.blowed_up.connect(on_rocket_blowed_up)
	
	var fling_vector = (%"Launch Pivot".global_position - %"Grabbed Indicator".global_position) * fling_scale
	
	new_rocket.fling(fling_vector)



func on_rocket_blowed_up(rocket : Rocket):
	if current_rocket == rocket:
		current_rocket = null
		
	
	
	
