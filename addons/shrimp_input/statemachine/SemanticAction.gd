@abstract
extends Node2D
class_name SemanticAction

signal unban()

@export var actionName: StringName = ""
@export var banned: bool = false

func _init(event: StringName = "") -> void:
	actionName = event

@abstract
func isPressed(inputNode: ShrimpInput) -> bool
# func getPosition() -> Vector2:
# 	return Vector2.ZERO

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
