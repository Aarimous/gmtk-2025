extends Node

var main : Main
var rng : RandomNumberGenerator


signal score_changed
signal enemy_count_changed
	
const gravity = 400.0 


enum FLOATING_TEXT_TYPES {
	ADD_SCORE,
	REMOVE_SCORE
}

enum ACTION_STATE {
	FREE,
	LAUNCHING_ROCKET
}

enum OBJECT_TYPE {
	ENEMY_SHIP,
	PLAYER_SATELLITE,
	PLAYER_SPACE_STATION
}

var action_state : ACTION_STATE = ACTION_STATE.FREE

var enemy_objects = []
var player_objects = []


func register_object(object):
	if object.type == Global.OBJECT_TYPE.ENEMY_SHIP:
		enemy_objects.append(object)
	else:
		player_objects.append(object)


func deregister_object(object):
	if enemy_objects.has(object):
		enemy_objects.erase(object)
	elif player_objects.has(object):
		player_objects.erase(object)


var enemy_count = 0 :
	set(new_value):
		if enemy_count > 0 and new_value == 0:
			main.game_over()
		enemy_count = new_value
		enemy_count_changed.emit()

var score : int = 0 :
	set(new_score):
		score = new_score
		score_changed.emit()

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	

func get_node2d_viewport_position(node2d : Node2D, camera):
	return node2d.global_position * camera.zoom + node2d.get_canvas_transform().origin
