extends Area

onready var selected_material : Material = preload("res://assets/selection/selected_material.tres")
onready var unselected_maetrial : Material = preload("res://assets/selection/unselected_material.tres")

func _ready() -> void:
	GameManager.deposit_global_position = $Position3D.global_transform.origin

func selected() -> void:
	DebugManager.debug("deposit", "selected")
	$SelectedMesh.material_override = selected_material
	
func unselected() -> void:
	$SelectedMesh.material_override = unselected_maetrial