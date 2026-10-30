extends Node
class_name SemanticAction

signal unban()

var inputEvent: StringName = ""
var banned: bool = false

func _init(event: StringName = "") -> void:
	inputEvent = event

func isPressed() -> bool:
	return Input.is_action_pressed(inputEvent)

func canPress() -> bool:
	var parent = get_parent()
	if is_instance_valid(parent) && parent is SemanticAction:
		return parent.canPress() && !banned
	else:
		return !banned
func ban(state: bool = true):
	banned = state
	if !state:
		unban.emit()
