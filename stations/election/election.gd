extends StaticBody


enum CORRECT {LEFT, CENTER, RIGHT}

#Tables
onready var left_table = $LeftTable
onready var right_table = $RightTable
onready var center_table = $CenterTable

var correct_left_table : bool = false
var correct_right_table : bool = false
var correct_center_table : bool = false

#Callenge 1
var umbrella : PackedScene = preload("res://stations/election/option/umbrella/Umbrella.tscn")
var shoe : PackedScene = preload("res://stations/election/option/shoe/Shoe.tscn")
var chicken : PackedScene = preload("res://assets/chicken/chicken.tscn")

var fish : PackedScene = preload("res://assets/fish/Fish.tscn")


var extinguisher : PackedScene = preload("res://assets/extinguisher/Estinguisher.tscn")

func start_rain_challenge(correct) -> void:
	left_table.set_option_model(umbrella.instance(), "umbrella", correct_left_table)
	right_table.set_option_model(shoe.instance(), "shoe", correct_right_table)
	center_table.set_option_model(chicken.instance(), "chicken", correct_center_table)

func start_cat_challenge(correct) -> void:
	right_table.set_option_model(fish.instance(), "shoe", correct_right_table)
	
func start_fire_challenge(correct) -> void:
	center_table.set_option_model(extinguisher.instance(), "chicken", correct_center_table)

func set_correct_option(correct) -> void:
	match CORRECT:
		CORRECT.LEFT:
			correct_left_table = true
		CORRECT.CENTER:
			correct_center_table = true
		CORRECT.RIGHT:
			correct_right_table = true
