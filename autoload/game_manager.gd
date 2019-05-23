extends Node

var deposit
var deposit_model
var options_in_game = {}
var option_node_selected
var deposit_global_position
var is_player_moving : bool = false
var gui
var score = 0

func set_options_in_game(options) -> void:
	options_in_game = options
