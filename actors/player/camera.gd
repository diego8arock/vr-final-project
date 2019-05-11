extends Camera

const ray_length = 1000
onready var ray_cast = $RayCast
onready var selectors = get_tree().get_nodes_in_group("selectors")
onready var options = get_tree().get_nodes_in_group("options")
onready var crosshair_sprite = $Node/Crosshair

func _ready() -> void:
	
	var size = get_viewport().size
	var posx = size.x / 2
	var posy = size.y / 2
	crosshair_sprite.position = Vector2(posx, posy)

func _process(delta: float) -> void:
	
	validate_collision()

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey and event.is_action_pressed("ui_select"):	
		action()

func validate_collision() -> void:
	
	for s in selectors:
		s.unselected()	
	
	for o in options:
		o.unselected()	
	
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.is_in_group("selectors"):
			collider.selected()	
		if collider.is_in_group("options"):
			collider.selected()	
	
func action() -> void:
	
	if ray_cast.is_colliding():	
		var collider = ray_cast.get_collider()
		DebugManager.debug("collider", collider)
			
		if collider.is_in_group("selectors"):
			var position = collider.get_node("Position3D").global_transform.origin
			get_tree().call_group("units", "move_to", position)		