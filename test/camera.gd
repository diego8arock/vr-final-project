extends Camera

onready var crosshair_sprite = $Node/Crosshair
onready var ray_cast = $RayCast
onready var selectors = get_tree().get_nodes_in_group("selectors")

func _ready() -> void:
	
	var size = get_viewport().size
	var posx = size.x / 2
	var posy = size.y / 2
	crosshair_sprite.position = Vector2(posx, posy)
	
	validate_collision()

func _process(delta: float) -> void:
	
	validate_collision()
		
func _input(event: InputEvent) -> void:
	
	if event is InputEventKey and event.is_action_pressed("ui_select"):	
		if ray_cast.is_colliding():	
			var collider = ray_cast.get_collider()
			
			if collider.is_in_group("selectors"):
				var position = collider.get_node("Position3D").global_transform.origin
				get_tree().call_group("units", "move_to", position)
			
			if collider.is_in_group("pickup"):
				collider.set_player($Position3D)
				pass
				
func validate_collision() -> void:
	
	for s in selectors:
		s.unselected()	
	
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.is_in_group("selectors"):
			collider.selected()	


	
