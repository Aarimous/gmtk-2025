extends StaticBody2D
class_name Satellite

@export var is_evil : bool = false


@export var type : Global.OBJECT_TYPE

var theta = 0

func _ready():
	match type:
		Global.OBJECT_TYPE.ENEMY_SHIP:
			modulate = Color.RED
			Global.enemy_count += 1
		Global.OBJECT_TYPE.PLAYER_SATELLITE:
			modulate = Color.GREEN
		Global.OBJECT_TYPE.PLAYER_SPACE_STATION:
			modulate = Color.GREEN
			
	Global.register_object(self)
	
	#if is_evil == true:
		#Global.enemy_count += 1
	#theta = deg_to_rad(Global.rng.randi_range(0, 360))

func destroy():
	Global.deregister_object(self)
	
	match type:
		Global.OBJECT_TYPE.ENEMY_SHIP:
			Global.enemy_count -= 1
	queue_free()
