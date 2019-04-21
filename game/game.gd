extends Spatial

func _ready():
	pass # Replace with function body.
	
	
func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


