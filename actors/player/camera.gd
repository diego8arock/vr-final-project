extends Camera

const ray_length = 1000
onready var ray_cast = $RayCast
onready var selectors = get_tree().get_nodes_in_group("selectors")
onready var options = get_tree().get_nodes_in_group("options")
onready var crosshair_sprite = $Node/Crosshair
onready var hand = get_parent().get_node("RightArm/Simple_Hand")

var is_hand_closed : bool = false

const vrpnClient = preload("res://bin/vrpnClient.gdns")
var clientGlove = null

func _ready() -> void:
	
	var size = get_viewport().size
	var posx = size.x / 2
	var posy = size.y / 2
	crosshair_sprite.position = Vector2(posx, posy)
	
	clientGlove = vrpnClient.new()
	clientGlove.connect("Glove14Left@localhost")

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
			action_close()
		else:
			DebugManager.debug("hand", "open")
			action_open()				

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey and event.is_action_pressed("ui_select"):	
		if not is_hand_closed:		
			action_close()
			is_hand_closed = true
		else:
			is_hand_closed = false

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
	
func action_close() -> void:
	
	if ray_cast.is_colliding():	
		var collider = ray_cast.get_collider()
		DebugManager.debug("collider", collider)
			
		if collider.is_in_group("selectors"):
			var position = collider.get_node("Position3D").global_transform.origin
			get_tree().call_group("units", "move_to", position)		
		
		if collider.is_in_group("options"):
			DebugManager.debug("player-option", collider)
			if not is_hand_closed:
				hand.get_node("AnimationPlayer").play("close")
				yield(hand.get_node("AnimationPlayer"), "animation_finished")
				is_hand_closed = true
			collider.set_origin($Position3D)
			get_tree().call_group("units", "move_to", GameManager.deposit_global_position)		
			
			
func action_open() -> void:		
	
	if ray_cast.is_colliding():	
		var collider = ray_cast.get_collider()
		DebugManager.debug("collider", collider)
			
		if collider.is_in_group("selectors"):
			var position = collider.get_node("Position3D").global_transform.origin
			get_tree().call_group("units", "move_to", position)			
			
			
			