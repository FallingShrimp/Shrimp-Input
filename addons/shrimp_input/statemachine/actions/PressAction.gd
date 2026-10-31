extends SemanticAction
class_name PressAction

func isPressed() -> bool:
	return Input.is_action_pressed(actionName)
