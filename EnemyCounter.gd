extends MarginContainer
class_name EnemyCounter

func _ready():
	Global.enemy_count_changed.connect(_on_enemy_count_changed)
	%Label.text = str(int(Global.enemy_count))
	
	
func _on_enemy_count_changed():
	%Label.text = str(int(Global.enemy_count))
