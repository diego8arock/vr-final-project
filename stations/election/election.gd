extends StaticBody


#Tables
onready var left_table = $LeftTable
onready var right_table = $RightTable
onready var center_table = $CenterTable

#Callenge 1
var c1o1_umbrella : PackedScene = preload("res://stations/election/option/umbrella/Umbrella.tscn")
var c1o2_shoe : PackedScene = preload("res://stations/election/option/shoe/Shoe.tscn")
var c1o3_bird

func _ready() -> void:
	_start_challenge_1()
	pass # Replace with function body.


func _start_challenge_1() -> void:	
	left_table.set_option_model(c1o1_umbrella.instance(), "umbrella", true)
	right_table.set_option_model(c1o2_shoe.instance(), "shoe", false)



