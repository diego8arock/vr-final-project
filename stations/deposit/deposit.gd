extends Area

onready var selected_material : Material = preload("res://assets/selection/selected_material.tres")
onready var unselected_maetrial : Material = preload("res://assets/selection/unselected_material.tres")

func _ready() -> void:
	pass # Replace with function body.

func selected() -> void:
	DebugManager.debug("deposit", "selected")
	$SelectedMesh.material_override = selected_material
	
func unselected() -> void:
	$SelectedMesh.material_override = unselected_maetrial