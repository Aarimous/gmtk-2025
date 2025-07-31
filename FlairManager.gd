extends Node2D
class_name FlairManager

@export var object_destroyed_parts_packed : PackedScene
@export var floating_text_packed : PackedScene



func create_particles_on_object_destoryed(glob_pos , color, size):
	var new_parts : GPUParticles2D = object_destroyed_parts_packed.instantiate()
	add_child(new_parts)
	new_parts.global_position = glob_pos
	new_parts.self_modulate = color
	#TODO size -> Emission radius
	new_parts.emitting = true
	
	
func create_new_floating_text(_glob_pos : Vector2, _text : String, _type : Global.FLOATING_TEXT_TYPES, _score_to_add):
	var floating_text : FloatingText = floating_text_packed.instantiate()
	Global.main.ui.add_child(floating_text)
		
	floating_text.setup(_glob_pos, _type, _text, _score_to_add)
	
