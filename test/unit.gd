extends KinematicBody


onready var player_cam = $Camera

#paths
var path = []
var path_ind = 0
onready var nav = get_parent()
onready var original_position_y : float = global_transform.origin.y

#physics
const move_speed : float = 5.0
var rotation_x = 0

const vrpnClient = preload("res://bin/vrpnClient.gdns")
var clientTracker = null

func _ready() -> void:
	start_vr()
	pass 

func _process(delta: float) -> void:
	clientTracker.mainloop()	
	
	if not(clientTracker.quat[0] == 0 and clientTracker.quat[1] == 0 and clientTracker.quat[2] == 0):
		var adjust_x = clientTracker.quat[0] * 10
		DebugManager.debug("clientTracker", adjust_x)
		
		if adjust_x < -0.7:
			rotation_x = -3
		elif adjust_x > 0.7:
			rotation_x = 3
		else:
			rotation_x = 0

func _physics_process(delta: float) -> void:
	
	rotate_y(deg2rad(20)* - rotation_x * delta)
	#player_cam.rotate_x(deg2rad(20) * - mouse_motion.y * sensitivity_y * delta)
	#player_cam.rotation.x = clamp(player_cam.rotation.x, deg2rad(-47), deg2rad(47))
	
	if path_ind < path.size():
		var path_sel = path[path_ind]
		path_sel.y = original_position_y
		var move_vec = (path_sel - global_transform.origin)
		if move_vec.length() < 0.1:
			path_ind += 1
		else:
			move_and_slide(move_vec.normalized() * move_speed, Vector3(0, 1, 0))

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey:
		
		if Input.is_action_just_pressed("ui_left"):
			rotation_x = -5
		if Input.is_action_just_pressed("ui_right"):
			rotation_x = 5
		if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
			rotation_x = 0

func move_to(target_pos) -> void:
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_ind = 0	
	
func start_vr() -> void:
	clientTracker = vrpnClient.new()
	clientTracker.connect("Tracker0@10.3.136.131")

	