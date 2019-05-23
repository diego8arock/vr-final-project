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
var abc : PackedScene = preload("res://assets/abc/Abc.tscn")
var pin : PackedScene = preload("res://assets/pin/Pin.tscn")

var extinguisher : PackedScene = preload("res://assets/extinguisher/Estinguisher.tscn")
var coin : PackedScene = preload("res://assets/coin/Coin.tscn")
var mug : PackedScene = preload("res://assets/mug/Mug.tscn")

func start_rain_challenge(correct) -> void:
	set_correct_option(correct)
	left_table.set_option_model(umbrella.instance(), "umbrella", correct_left_table)
	right_table.set_option_model(shoe.instance(), "shoe", correct_right_table)
	center_table.set_option_model(chicken.instance(), "chicken", correct_center_table)

func start_cat_challenge(correct) -> void:
	set_correct_option(correct)
	left_table.set_option_model(abc.instance(), "abc", correct_left_table)
	right_table.set_option_model(fish.instance(), "fish", correct_right_table)
	center_table.set_option_model(pin.instance(), "pin", correct_center_table)
	
func start_fire_challenge(correct) -> void:
	set_correct_option(correct)
	center_table.set_option_model(extinguisher.instance(), "extinguisher", correct_center_table)
	left_table.set_option_model(coin.instance(), "coin", correct_left_table)
	right_table.set_option_model(mug.instance(), "mug", correct_right_table)

func set_correct_option(correct) -> void:
	match correct:
		CORRECT.LEFT:
			correct_left_table = true
		CORRECT.CENTER:
			correct_center_table = true
		CORRECT.RIGHT:
			correct_right_table = true
		_:
			DebugManager.debug(name + "error",correct)
