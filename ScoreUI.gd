extends MarginContainer
class_name ScoreUI


func _ready() -> void:
	Global.score_changed.connect(_on_score_changed)
	%Label.text = str(int(Global.score))
	pivot_offset = size/2.0
	

func get_text_location():
	return %Label.global_position + Vector2(%Label.size.x/2.0, %Label.size.y)
	
func _on_score_changed():
	%Label.text = str(int(Global.score))
	animate()

var scale_tween : Tween	
func animate():
	pivot_offset = size/2.0
	if scale_tween and scale_tween.is_running():
		scale_tween.kill()
		scale = Vector2.ONE
	scale_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	scale_tween.tween_property(self, "scale", Vector2(1.33, 1.33), .2)
	scale_tween.tween_property(self, "scale", Vector2(1, 1), .15)
