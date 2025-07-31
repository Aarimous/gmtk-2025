extends HBoxContainer
class_name FloatingText

var duration = .5
var type : Global.FLOATING_TEXT_TYPES
var score_to_add : int

func setup(_glob_pos : Vector2, _type : Global.FLOATING_TEXT_TYPES, _text : String = "", _score_to_add = 0):
	type = _type
	
	pivot_offset = size/2.0
	scale = Vector2(.5, .5)
	global_position = _glob_pos
	score_to_add = _score_to_add
	
	
	match type:
		Global.FLOATING_TEXT_TYPES.ADD_SCORE:
			$Label.add_theme_color_override("font_color", Color.GREEN)
			$Label.text = _text
			reset_size()
			create_tween_to_score_ui()
		Global.FLOATING_TEXT_TYPES.REMOVE_SCORE:
			$Label.add_theme_color_override("font_color",  Color.RED)
			$Label.text = _text
			reset_size()
			create_tween_to_score_ui()
	


#func create_damage_tween():
	#var to_position = Vector2(Global.rng.randi_range(-32, 32), -Global.rng.randi_range(64, 72))
	#var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	#tween.tween_property(self, "global_position", global_position + to_position, .33)
	#tween.parallel().tween_property(self, "scale", Vector2(1.25, 1.25), .33)
	#tween.chain().tween_property(self, "scale", Vector2(1, 1), .1)
	#tween.tween_interval(.1)
	#tween.tween_property(self, "modulate:a", 0.0, .33)
	#tween.tween_callback(queue_free)
	
	
func create_tween_to_score_ui():
	#var to_position = Global.main.global_resoruces_ui.get_resource_icon_global_position_by_type(Global.RESOURCE_TYPES.MATTER)
	print("-size.x ", -size.x)
	var to_position = Global.main.score_ui.get_text_location() + Vector2(-%Label.size.x/2.0, 0)
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	
	tween.tween_property(self, "scale", Vector2(1.25, 1.25), .2)
	tween.tween_property(self, "scale", Vector2(1, 1), .1)
	tween.tween_property(self, "global_position", to_position, .5)
	#tween.parallel()tween_property(self, "scale", Vector2(1.5, 1.5), .2)
	
	
	tween.tween_callback(func(): Global.score += score_to_add)
	tween.tween_interval(.2)
	tween.tween_property(self, "modulate:a", 0.0, .33)
	tween.parallel().tween_property(self, "global_position" , to_position + Vector2(0, -32), .33)
	
	tween.tween_callback(queue_free)
