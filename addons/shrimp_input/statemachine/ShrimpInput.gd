extends Node
class_name ShrimpInput

func isPressed(action: SemanticAction) -> bool:
	if !action.canAction(): return false
	return Input.is_action_pressed(action.inputEvent)
