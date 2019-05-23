extends Control

onready var message = $MarginContainer/VBoxContainer/Message
onready var score = $MarginContainer/VBoxContainer/Score

func _ready() -> void:
	message.text = ""
	score.text = ""
	GameManager.gui = self
	
func set_message(_message):
	message.text = _message
	
func set_score(_score):
	score.text = "Score: " + str(_score)
	
func update_score():
	score.text = "Score: " + str(GameManager.score)

