extends KinematicBody

# http://robotics.usc.edu/~parnandi/wii.html
# lswm
# sudo wminput 00:19:1D:87:B4:45

#constants
const GRAVITY = 9.8
const OPTION_NODE_NAME = "Option"

#paths
var path = []
var path_ind = 0
onready var nav = get_parent()

#mouse sensitivity
export(float,0.1,1.0) var sensitivity_x = 0.5
export(float,0.1,1.0) var sensitivity_y = 0.4

#physics
const move_speed : float = 5.0

#instances ref
onready var player_cam = $Camera
onready var player_arm = $RightArm
onready var ray_cast = $Camera/RayCast
onready var player_hand = $RightArm/RightHand

#variables
var mouse_motion = Vector2()
var is_option_on_ray_cast = false
var option_node_selected = null
var is_option_choosed = false
var rotation_x = 0

func _ready() -> void:
	add_to_group("units")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	
	#camera and body rotation
	rotate_y(deg2rad(20)* - rotation_x * delta)
#	player_cam.rotate_x(deg2rad(20) * - mouse_motion.y * sensitivity_y * delta)
#	player_cam.rotation.x = clamp(player_cam.rotation.x, deg2rad(-47), deg2rad(47))
#	player_arm.rotation.x = lerp(player_arm.rotation.x, player_cam.rotation.x, 0.2)
#	mouse_motion = Vector2()
	
	if path_ind < path.size():
		var move_vec = (path[path_ind] - global_transform.origin)
		if move_vec.length() < 0.1:
			path_ind += 1
		else:
			move_and_slide(move_vec.normalized() * move_speed, Vector3(0, 1, 0))	

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		var motion = event.relative.x
		if motion > 3:
			rotation_x = 5
		elif motion < -3:
			rotation_x = -5
		else:
			rotation_x = 0
	
	if event is InputEventKey:
		
		if Input.is_action_just_pressed("ui_left"):
			rotation_x = -5
		if Input.is_action_just_pressed("ui_right"):
			rotation_x = 5
		if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
			rotation_x = 0

#func _axis() -> Vector3:
#	var direction = Vector3()
#
#	if Input.is_key_pressed(KEY_W):
#		direction -= get_global_transform().basis.z.normalized()
#
#	if Input.is_key_pressed(KEY_S):
#		direction += get_global_transform().basis.z.normalized()
#
#	if Input.is_key_pressed(KEY_A):
#		direction -= get_global_transform().basis.x.normalized()
#
#	if Input.is_key_pressed(KEY_D):
#		direction += get_global_transform().basis.x.normalized()
#
#	return direction.normalized()
	
func _detect_ray_cast_collision() -> bool:
	return false
	
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_ind = 0