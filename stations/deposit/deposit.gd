extends Area

onready var selected_material : Material = preload("res://assets/selection/selected_material.tres")
onready var unselected_maetrial : Material = preload("res://assets/selection/unselected_material.tres")
signal finished

func _ready() -> void:
	GameManager.deposit_global_position = $Position3D.global_transform.origin
	GameManager.deposit_model = $ModelPosition
	GameManager.deposit = self

func selected() -> void:
	DebugManager.debug("deposit", "selected")
	$SelectedMesh.material_override = selected_material
	
func unselected() -> void:
	$SelectedMesh.material_override = unselected_maetrial
	
func set_model(model) -> void:
	model.global_transform.origin = $ModelPosition.global_transform.origin
	
func play_sound(is_correct):
	if is_correct:
		$CorrectSound.play()
		yield($CorrectSound, "finished")	
	else:
		$WrongSound.play()
		yield($WrongSound, "finished")
	emit_signal("finished")