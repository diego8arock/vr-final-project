extends StaticBody

enum CHALLENGE {FIRE, RAIN, CAT}
export (CHALLENGE) var challenge 

func _ready() -> void:
	match challenge:
		CHALLENGE.FIRE:
			$Challenge.update_challenge(CHALLENGE.FIRE)
		CHALLENGE.RAIN:
			$Challenge.update_challenge(CHALLENGE.RAIN)
		CHALLENGE.CAT:
			$Challenge.update_challenge(CHALLENGE.CAT)

