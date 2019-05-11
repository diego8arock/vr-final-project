extends Spatial

func _ready():
	#OS.set_window_maximized(true)
	pass
	
func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


