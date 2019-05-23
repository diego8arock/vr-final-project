extends StaticBody

enum CHALLENGE {FIRE, RAIN, CAT}
var is_challenge_set : bool = false

func update_challenge(challenge):
	match challenge:
		CHALLENGE.FIRE:
			$Challenges/Fire.show()
			$Challenges/Cat/AudioStreamPlayer3D.stop()
			$Challenges/Rain/AudioStreamPlayer3D.stop()
		CHALLENGE.RAIN:
			$Challenges/Rain.show()
			$Challenges/Cat/AudioStreamPlayer3D.stop()
			$Challenges/Fire/AudioStreamPlayer3D.stop()
		CHALLENGE.CAT:
			$Challenges/Cat.show()
			$Challenges/Fire/AudioStreamPlayer3D.stop()
			$Challenges/Rain/AudioStreamPlayer3D.stop()
	

