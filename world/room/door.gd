extends Spatial

onready var selected_material : Material = preload("res://assets/selection/selected_material.tres")
onready var unselected_maetrial : Material = preload("res://assets/selection/unselected_material.tres")

onready var animation_player = $AnimationPlayer

var is_player_inside_room : bool = false

func _ready() -> void:
	pass
	
func selected() -> void:
	$SelectedMesh.material_override = selected_material
	
func unselected() -> void:
	$SelectedMesh.material_override = unselected_maetrial

func _on_TriggerPlayer_body_entered(body: Node) -> void:
	DebugManager.debug(name, "body entered " + body.name)
	if body.name == "KinematicBody":
		animation_player.play("open_door")

func _on_TriggerPlayer_body_exited(body: Node) -> void:
	DebugManager.debug(name, "body exited "+ body.name)
	if body.name == "KinematicBody":
		animation_player.play("close_door")
