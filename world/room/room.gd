extends StaticBody

enum CHALLENGE {FIRE, RAIN, CAT}
export (CHALLENGE) var challenge 

enum CORRECT {LEFT, CENTER, RIGHT}
export (CORRECT) var correct_answer

func _ready() -> void:
	match challenge:
		CHALLENGE.FIRE:
			$Challenge.update_challenge(CHALLENGE.FIRE)
			$Election.start_fire_challenge(correct_answer)
		CHALLENGE.RAIN:
			$Challenge.update_challenge(CHALLENGE.RAIN)
			$Election.start_rain_challenge(correct_answer)
		CHALLENGE.CAT:
			$Challenge.update_challenge(CHALLENGE.CAT)
			$Election.start_cat_challenge(correct_answer)

