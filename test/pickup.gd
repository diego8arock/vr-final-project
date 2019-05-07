extends Area

var player_origin = null
var distance = 10

func _ready() -> void:
	pass # Replace with function body.

func set_player(origin) -> void:
	player_origin = origin

func _process(delta: float) -> void:
	
	if player_origin:
		var new_origin = player_origin.global_transform.origin
		global_transform.origin = new_origin
