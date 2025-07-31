extends CharacterBody2D
class_name Rocket

#var velocity : Vector2  = Vector2.ZERO
var lifetime = 0.0
var thrust = 1.0


var last_distance_to_earth = 0.0
var is_returning_to_earth = false


signal blowed_up(rocket : Rocket)



#var primed = false :
	#set(new_value):
		#primed = new_value
		#%Icon.self_modulate = Color.GREEN if primed else Color.RED

func _ready():
	#primed = false
	set_physics_process(false)


func _physics_process(delta):
	lifetime += delta
	
	var distance_to_earth = global_position.length()
	is_returning_to_earth = distance_to_earth < last_distance_to_earth
	#if  is_returning_to_earth == true:
		#print("I'm coming home MOM!!")
	last_distance_to_earth = distance_to_earth
	
	
	
	var direction_to_center = global_position.normalized()
	velocity -= direction_to_center * Global.gravity * delta
	
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision != null:
		
		if collision.get_collider() is Trampoline:
			velocity = velocity.bounce(collision.get_normal())
		elif collision.get_collider() is Moon:
			velocity = velocity.bounce(collision.get_normal())
			#pass
		else:
			blow_up()
		#pass
	#global_position += velocity * delta
	
	
	#thrust -= delta
	#if thrust > 0:
		#velocity += velocity.normalized() * 200 * delta
		#keep add energy to the system
	#var dot_product = velocity.dot(direction_to_center)
	
	#var dir = sign(dot_product)
	
	#var tangential_direction = Vector2(-direction_to_center.y, dir * direction_to_center.x)
	#var distance = global_position.length()
	#var speed = sqrt(Global.gravity / distance)
	#
	#var diff = direction_to_center - velocity 
	#velocity -= direction_to_center * Global.gravity * delta

	
	#global_position += velocity * delta
	


	
func fling(thrust_vector : Vector2):
	print("Fling : ", thrust_vector.length())
	velocity = thrust_vector

	set_physics_process(true)
	
	#$Timer.start()


#func _on_area_entered(area: Area2D) -> void:
	#if area is Trampoline:
		#velocity = velocity.reflect(area)
	#
	#else:
		#blow_up()
	#if area is Earth:
		#blow_up()
		#
	#if area is Satellite:
		#var from_pos = Global.get_node2d_viewport_position(area, Global.main.camera_2d)
		#if area.is_evil == false:
			#pass
			##Global.main.flair_manager.create_new_floating_text(from_pos, str("-100"), Global.FLOATING_TEXT_TYPES.REMOVE_SCORE, -100)
		#else:
			#var score = 200 if is_returning_to_earth else 100
			#Global.main.flair_manager.create_new_floating_text(from_pos, str("+", score), Global.FLOATING_TEXT_TYPES.ADD_SCORE, score)
		#
		#area.destroy()
		#blow_up()
		
func blow_up():
	#if primed == false:
		#return
		
	for body in %"Explosion AOE".get_overlapping_bodies():
		if body is Satellite:
			var from_pos = Global.get_node2d_viewport_position(body, Global.main.camera_2d)
			if body.type != Global.OBJECT_TYPE.ENEMY_SHIP:
				pass
				#Global.main.flair_manager.create_new_floating_text(from_pos, str("-100"), Global.FLOATING_TEXT_TYPES.REMOVE_SCORE, -100)
			else:
				var score = 200 if is_returning_to_earth else 100
				Global.main.flair_manager.create_new_floating_text(from_pos, str("+", score), Global.FLOATING_TEXT_TYPES.ADD_SCORE, score)
		body.destroy()
		
	blowed_up.emit(self)
	
	
	set_physics_process(false)
	%ExplosionArt.modulate.a = 1
	%ExplosionArt.show()
	%Icon.visible = false
	var tween = create_tween()
	tween.tween_property(%"Explosion Pivot", "scale", Vector2.ONE, .05).from(Vector2.ZERO)
	tween.tween_property(%ExplosionArt, "modulate:a", 0.5, .25)
	tween.tween_callback(queue_free)
	

#func _on_timer_timeout() -> void:
	#%CollisionShape2D.disabled = false


#func _on_area_exited(area: Area2D) -> void:
	#if area is LaunchSite:
		#primed = true
