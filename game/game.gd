extends Spatial

func _ready():
	get_tree().paused = true
	pass
	
func _process(delta: float) -> void:
	if $GameStart.time_left != 0:
		GameManager.gui.set_message("Game Starting in: " + str(int($GameStart.time_left)))	
	
func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_GameStart_timeout() -> void:
	GameManager.gui.set_message("")
	get_tree().paused = false
	GameManager.gui.set_score(GameManager.score)
