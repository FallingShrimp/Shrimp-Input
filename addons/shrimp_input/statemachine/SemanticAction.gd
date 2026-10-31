@abstract
extends Node
class_name SemanticAction

signal unban()

@export var actionName: StringName = ""
@export var banned: bool = false

func _init(event: StringName = "") -> void:
	actionName = event

@abstract
func isPressed() -> bool

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
