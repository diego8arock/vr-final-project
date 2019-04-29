extends StaticBody

onready var option = $Option

onready var selected_material : Material = preload("res://stations/election/table/selected_material.tres")
onready var unselected_maetrial : Material = preload("res://stations/election/table/unselected_material.tres")

var rotation_speed : float = 10.0

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	option.rotate(Vector3(0, 1, 0), (rotation_speed * PI / 180) * delta)
	
func set_option_model(model : Node, name : String) -> void:
	option.set_model(model, name)

func selected() -> void:
	$SelectedMesh.material_override = selected_material
	
func unselected() -> void:
	$SelectedMesh.material_override = unselected_maetrial