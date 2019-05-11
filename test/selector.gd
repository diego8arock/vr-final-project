extends Area

onready var selected = preload("res://assets/selection/selected_material.tres")
onready var unselected = preload("res://assets/selection/unselected_material.tres")

func _ready() -> void:
	$MeshInstance.material_override = unselected	

func selected() -> void:
	$MeshInstance.material_override = selected
	
func unselected() -> void:
	$MeshInstance.material_override = unselected


