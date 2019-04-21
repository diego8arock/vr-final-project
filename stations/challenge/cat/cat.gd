extends Spatial


func _ready():
	$AnimationPlayer.play("default")
	pass 

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("default")
