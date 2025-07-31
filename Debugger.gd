extends PanelContainer
class_name Debugger

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Debugger") and Global.main.is_dev_mode == true:
		visible = !visible
		
func _process(delta: float) -> void:
	%FPS.text = str("FPS : ", int(Engine.get_frames_per_second()))

func _on__score_pressed() -> void:
	Global.score += 100
