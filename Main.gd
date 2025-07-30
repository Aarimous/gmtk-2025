extends Node2D
class_name Main

@onready var rockets: Node2D = %Rockets

func _ready():
	Global.main = self
	
