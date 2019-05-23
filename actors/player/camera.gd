extends Camera

const ray_length = 1000
onready var ray_cast = $RayCast
onready var selectors = get_tree().get_nodes_in_group("selectors")
onready var options = get_tree().get_nodes_in_group("options")
onready var crosshair_sprite = $Node/Crosshair
onready var hand = get_parent().get_node("RightArm/Simple_Hand")
onready var player = get_parent()

var is_hand_closed : bool = false
var collider_selected
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
		else:
			action_open()
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
			collider_selected = collider
			collider_selected.set_origin($Position3D)
			get_tree().call_group("units", "move_to", GameManager.deposit_global_position)		
			
			
func action_open() -> void:		
	
	var dx = GameManager.deposit_global_position.x - player.global_transform.origin.x
	var dy = GameManager.deposit_global_position.y - player.global_transform.origin.y
	var distance = sqrt( pow(dx,2) + pow(dy,2) )
	
	if distance < 0.5:
		hand.get_node("AnimationPlayer").play_backwards("close")
		yield(hand.get_node("AnimationPlayer"), "animation_finished")
		collider_selected.set_origin(GameManager.deposit_model)
		GameManager.gui.set_message("CORRECT!" if collider_selected.is_correct_option else "INCORRECT!")
		GameManager.score += 10 if collider_selected.is_correct_option else -10
		GameManager.gui.update_score()
		GameManager.deposit.play_sound(collider_selected.is_correct_option)
		yield(GameManager.deposit, "finished")		
		if GameManager.validate_end_game(collider_selected.is_correct_option):
			is_hand_closed = false
			yield(get_tree().create_timer(1.0), "timeout")
			GameManager.gui.set_message("")
			collider_selected.hide()
			collider_selected.disable()
		
		
			
			
			