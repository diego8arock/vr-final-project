extends Area

var is_correct_option : bool = false
var option_name : String = "test"
var is_new_origin : bool = false
var new_origin : Node
onready var init_scale = $MeshInstance.scale
var model

func _process(delta: float) -> void:
	
	if new_origin:
		self.global_transform.origin = new_origin.global_transform.origin

func set_model(_model : Node, name : String, is_correct_answer : bool) -> void:
	model = _model
	add_child(model)
	option_name = name
	$MeshInstance.hide()
	is_correct_option = is_correct_answer

func selected() -> void:
	get_parent().selected()
	
func unselected() -> void:
	get_parent().unselected()
		
func set_origin(_new_origin : Node) -> void:
	new_origin = _new_origin
	new_origin.global_transform.origin.y = 2.5
	is_new_origin = true
	var child : Spatial = get_children()[2]
	child.scale = Vector3(0.5,0.5,0.5)

