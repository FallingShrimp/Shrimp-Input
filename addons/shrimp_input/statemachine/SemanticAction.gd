@abstract
extends Node2D
class_name SemanticAction

signal unban()

@export var actionName: StringName = ""
@export var banned: bool = false

func _init(event: StringName = "", parent: SemanticAction = null) -> void:
	actionName = event
	if is_instance_valid(parent):
		parent.add_child(self)

@abstract
func isPressed(inputNode: ShrimpInput) -> bool
func getPosition() -> Vector2:
	return Vector2.ZERO

func canPress() -> bool:
	var parent = get_parent()
	if banned:
		return false
	elif is_instance_valid(parent) && parent is SemanticAction:
		return parent.canPress()
	else:
		return true
func ban(state: bool = true):
	banned = state
	if !state:
		unban.emit()
