extends Camera

onready var crosshair_sprite = $Node/Crosshair
onready var ray_cast = $RayCast
onready var selectors = get_tree().get_nodes_in_group("selectors")

const vrpnClient = preload("res://bin/vrpnClient.gdns")
var clientGlove = null

var pickup = null

func _ready() -> void:
	
	var size = get_viewport().size
	var posx = size.x / 2
	var posy = size.y / 2
	crosshair_sprite.position = Vector2(posx, posy)
	
	clientGlove = vrpnClient.new()
	clientGlove.connect("Glove14Right@localhost")
	
	validate_collision()

func _process(delta: float) -> void:
	
	validate_collision()
	
	clientGlove.mainloop()
	
	if(clientGlove.analog.size() == 14):
		var adjust_sensor = clientGlove.analog[1] * 10
		DebugManager.debug("clientGlove", adjust_sensor)
		if ray_cast.is_colliding():	
			DebugManager.debug("colliding with", ray_cast.get_collider())
			
		if adjust_sensor > 5:
			DebugManager.debug("hand", "close")
			action()
		else:
			DebugManager.debug("hand", "open")
		
func _input(event: InputEvent) -> void:
	
	if event is InputEventKey and event.is_action_pressed("ui_select"):	
		action()
				
func validate_collision() -> void:
	
	for s in selectors:
		s.unselected()	
	
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.is_in_group("selectors"):
			collider.selected()	

func action() -> void:
	
	DebugManager.debug("pickup", pickup)
	
	if ray_cast.is_colliding():	
		var collider = ray_cast.get_collider()
		DebugManager.debug("collider", collider)
			
		if collider.is_in_group("selectors"):
			var position = collider.get_node("Position3D").global_transform.origin
			get_tree().call_group("units", "move_to", position)
			
		if collider.is_in_group("pickup") and not pickup and $PickupTimer.time_left == 0:
			pickup = collider
			pickup.set_player($Position3D)
			get_tree().call_group("deposits", "unset_object")
			DebugManager.debug("can-pickup-deposit", "false")
			$PickupTimer.start()
			
		if collider.is_in_group("deposits") and pickup and $PickupTimer.time_left == 0:
			pickup.unset_player()
			collider.set_object(pickup)
			DebugManager.debug("can-pickup-deposit", "false")
			$PickupTimer.start()
			pickup = null		
			

func _on_PickupTimer_timeout() -> void:
	DebugManager.debug("can-pickup-deposit", "true")
	pass # Replace with function body.
