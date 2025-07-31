extends MarginContainer
class_name TimerUI

var time_left = 60 :
	set(new_value):
		if time_left > 0.0 and new_value <= 0.0:
			Global.main.game_over()
			
		time_left = max(new_value, 0.0)
		%Label.text = str( int(time_left), "s" )

func _process(delta: float) -> void:
	if Global.main.is_game_over == false:
		time_left -= delta
