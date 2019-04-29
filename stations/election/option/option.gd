extends Area

var is_correct_option : bool = false
var option_name : String = "test"

var is_option_selected = false

signal option_selected
signal option_unselected

func _ready() -> void:
	connect("option_selected", get_parent(), "selected")
	connect("option_unselected", get_parent(), "unselected")
	
func set_model(model : Node, name : String) -> void:
	add_child(model)
	option_name = name
	$MeshInstance.hide()
	pass

func player_selected() -> void:
	if not is_option_selected:
		emit_signal("option_selected")
		is_option_selected = true
	
func player_unselected() -> void:
	if is_option_selected:
		emit_signal("option_unselected")
		is_option_selected = false
		
func set_origin(new_origin : Vector3) -> void:
	var posx = new_origin.x
	var posy = new_origin.y
	var posz = new_origin.z
	self.transform.origin = Vector3(posx, posy, posz)
