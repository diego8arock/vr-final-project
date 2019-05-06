extends Camera

const ray_length = 1000
onready var ray_cast = $RayCast

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		if ray_cast.is_colliding():
			get_tree().call_group("units", "move_to", ray_cast.get_collision_point())
			