extends StaticBody

enum CHALLENGE {FIRE, RAIN, CAT}
var is_challenge_set : bool = false

func update_challenge(challenge):
	match challenge:
		CHALLENGE.FIRE:
			$Challenges/Fire.show()
		CHALLENGE.RAIN:
			$Challenges/Rain.show()
		CHALLENGE.CAT:
			$Challenges/Cat.show()
	

