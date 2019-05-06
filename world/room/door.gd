extends StaticBody

onready var animation_player = $AnimationPlayer
onready var door_collition = $CollisionShape

var is_player_inside_room : bool = false

func _ready() -> void:
	door_collition.disabled = false

func _on_TriggerPlayer_body_entered(body: Node) -> void:
	if body.name == "KinematicBody":
		door_collition.disabled = true
		animation_player.play("open_door")


func _on_TriggerPlayer_body_exited(body: Node) -> void:
	if body.name == "KinematicBody":
		door_collition.disabled = false
		animation_player.play("close_door")
