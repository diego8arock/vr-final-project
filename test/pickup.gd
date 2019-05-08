extends Area

var player_origin = null
var distance = 10

func _ready() -> void:
	pass # Replace with function body.

func set_player(origin) -> void:
	player_origin = origin
	player_origin.global_transform.origin.y = 2.5
	$CollisionShape.disabled = true
	
func unset_player() -> void:
	player_origin = null
	$CollisionShape.disabled = false

func _process(delta: float) -> void:
	
	if player_origin:
		global_transform.origin = player_origin.global_transform.origin
