extends Area

func selected() -> void:
	get_parent().selected()
	
func unselected() -> void:
	get_parent().unselected()
