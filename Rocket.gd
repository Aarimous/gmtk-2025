extends Area2D
class_name Rocket

var velocity : Vector2  = Vector2.ZERO
var lifetime = 0.0
var thrust = 1.0



var primed = false :
	set(new_value):
		primed = new_value
		modulate = Color.GREEN if primed else Color.RED

func _ready():
	primed = false
	set_physics_process(false)


func _physics_process(delta):
	lifetime += delta
	
	var direction_to_center = global_position.normalized()
	velocity -= direction_to_center * Global.gravity * delta
	global_position += velocity * delta
	
	
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


func _on_area_entered(area: Area2D) -> void:
	if area is Earth:
		blow_up()
		
	if area is Satellite:
		area.destroy()
		blow_up()
		
func blow_up():
	if primed == true:
		queue_free()

#func _on_timer_timeout() -> void:
	#%CollisionShape2D.disabled = false


func _on_area_exited(area: Area2D) -> void:
	if area is LaunchSite:
		primed = true
