extends Area2D
class_name Portal

@export var linked_portal : Portal

var theta = 0


var white_list = []


func _on_body_entered(body: Node2D) -> void:
	if body not in white_list:
		linked_portal.white_list.append(body)
		body.global_position = linked_portal.global_position


func _on_body_exited(body: Node2D) -> void:
	if white_list.has(body):
		white_list.erase(body)
	pass # Replace with function body.
