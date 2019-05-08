extends Area


func _ready() -> void:
	pass 

func set_object(object) -> void:
	object.global_transform.origin = $SetPosition.global_transform.origin
	$CollisionShape.disabled = true;
	
func unset_object() -> void:
	$CollisionShape.disabled = false;
	
