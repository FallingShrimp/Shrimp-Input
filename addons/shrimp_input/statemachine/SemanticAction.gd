extends Node
class_name SemanticAction

var inputEvent: StringName = ""
var banned: bool = false

func _init(event: StringName = "") -> void:
	inputEvent = event

func canAction() -> bool:
	var parent = get_parent()
	if is_instance_valid(parent) && parent is SemanticAction:
		return parent.canAction() && !banned
	else:
		return !banned
