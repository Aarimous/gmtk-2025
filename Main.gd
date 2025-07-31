extends Node2D
class_name Main

@onready var rockets: Node2D = %Rockets
@onready var score_ui: ScoreUI = %ScoreUI
@onready var flair_manager: FlairManager = %FlairManager
@onready var ui: CanvasLayer = %UI
@onready var camera_2d: Camera2D = %Camera2D

var is_game_over = false


@export var is_dev_mode : bool = false
func _ready():
	Global.main = self
	%"Score Screen".hide()
	

func _on_play_again_pressed() -> void:
	new_game()
	get_tree().reload_current_scene()
	
	
func new_game():
	Global.enemy_count = 0
	Global.enemy_objects = []
	Global.player_objects = []
	#$get_tree().reload_current_scene()
	
func game_over():
	is_game_over = true
	%"Score Screen".show()
	pass
