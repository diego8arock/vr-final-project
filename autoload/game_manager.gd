extends Node

var deposit
var deposit_model
var options_in_game = {}
var option_node_selected
var deposit_global_position
var is_player_moving : bool = false
var gui
var score = 0
var correct_choices : int = 0
var player

func validate_end_game(is_choice_correct) -> bool:
	correct_choices += 1 if is_choice_correct else 0
	if correct_choices == 3:
		get_tree().paused = true
		if score == 30:
			gui.set_message("Congratulations, you go a perfect score!")
		elif score == 20:
			gui.set_message("Good job, you almost got it!")
		elif score == 10:
			gui.set_message("Well done, but you still need to pratice!")
		else:
			gui.set_message("Sorry, but you made too many mistakes!")
		return false
	return true