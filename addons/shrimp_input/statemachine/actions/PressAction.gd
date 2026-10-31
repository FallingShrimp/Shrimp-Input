extends SemanticAction
class_name PressAction

func isPressed(_i) -> bool:
	return Input.is_action_pressed(actionName)
