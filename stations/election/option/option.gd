extends Area

var is_correct_option : bool = false
var option_name : String = "test"

func set_model(model : Node, name : String) -> void:
	add_child(model)
	option_name = name
	$MeshInstance.hide()
	pass

func selected() -> void:
	get_parent().selected()
	
func unselected() -> void:
	get_parent().unselected()
		
func set_origin(new_origin : Vector3) -> void:
	var posx = new_origin.x
	var posy = new_origin.y
	var posz = new_origin.z
	self.transform.origin = Vector3(posx, posy, posz)
