extends Node

var _debug

signal debug_updated(node,text)
signal debug_delete(node)

func _ready():
	if get_tree().get_root().has_node("Game"):
		_debug = get_tree().get_root().get_node("Game").get_node("Debug")
		connect("debug_updated", _debug, "_on_signal_updateLabel")
		connect("debug_delete", _debug, "_on_signal_deleteLabel")

func debug(_node, _text, do_debug = false) -> void:
	if do_debug:
		emit_signal("debug_updated", _node, str(_text))

func debug_remove(_node) -> void:
	emit_signal("debug_delete", _node)
