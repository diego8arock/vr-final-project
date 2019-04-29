extends KinematicBody

#constants
const GRAVITY = 9.8
const OPTION_NODE_NAME = "Option"

#mouse sensitivity
export(float,0.1,1.0) var sensitivity_x = 0.5
export(float,0.1,1.0) var sensitivity_y = 0.4

#physics
export(float,10.0, 30.0) var speed = 15.0
export(float,1.0, 10.0) var mass = 8.0
export(float,0.1, 3.0, 0.1) var gravity_scl = 1.0

#instances ref
onready var player_cam = $Camera
onready var player_arm = $RightArm
onready var ray_cast = $Camera/RayCast
onready var player_hand = $RightArm/RightHand

#variables
var mouse_motion = Vector2()
var gravity_speed = 0
var is_option_on_ray_cast = false
var option_node_selected = null
var is_option_choosed = false

#signals
signal set_origin(new_origin)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass


func _physics_process(delta: float) -> void:
	
	#camera and body rotation
	rotate_y(deg2rad(20)* - mouse_motion.x * sensitivity_x * delta)
	player_cam.rotate_x(deg2rad(20) * - mouse_motion.y * sensitivity_y * delta)
	player_cam.rotation.x = clamp(player_cam.rotation.x, deg2rad(-47), deg2rad(47))
	player_arm.rotation.x = lerp(player_arm.rotation.x, player_cam.rotation.x, 0.2)
	mouse_motion = Vector2()
	
	#gravity
	gravity_speed -= GRAVITY * gravity_scl * mass * delta
	
	#character moviment
	var velocity = Vector3()
	velocity = _axis() * speed
	velocity.y = gravity_speed
	
	gravity_speed = move_and_slide(velocity).y
	
	is_option_on_ray_cast = _detect_ray_cast_collision()	
	
	#if is_option_choosed:
	#	emit_signal("set_origin", player_hand.global_transform.origin)
		

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		mouse_motion = event.relative
		
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			_select_option()

func _axis() -> Vector3:
	var direction = Vector3()
	
	if Input.is_key_pressed(KEY_W):
		direction -= get_global_transform().basis.z.normalized()
		
	if Input.is_key_pressed(KEY_S):
		direction += get_global_transform().basis.z.normalized()
		
	if Input.is_key_pressed(KEY_A):
		direction -= get_global_transform().basis.x.normalized()
		
	if Input.is_key_pressed(KEY_D):
		direction += get_global_transform().basis.x.normalized()
		
	return direction.normalized()
	
func _detect_ray_cast_collision() -> bool:
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		var exists_option_selected = false
		
		if collider.name == OPTION_NODE_NAME:
			for op in GameManager.options_in_game:
				if GameManager.options_in_game[op]: 
					var option = GameManager.options_in_game[op]
					if collider.option_name == option.option_name:
						option.player_selected()
						exists_option_selected = true
						option_node_selected = collider
					else:
						option.player_unselected()
		
		return exists_option_selected
	else:
		return false
						
func _select_option() -> void:
	if is_option_on_ray_cast:
		GameManager.option_node_selected = option_node_selected	
		connect("set_origin", option_node_selected, "set_origin") 	
		is_option_choosed = true
		print(option_node_selected)
	pass