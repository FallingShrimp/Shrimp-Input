extends Node
class_name ShrimpInput

func press(action: SemanticAction, timeout: float = INF) -> float:
	var start = ShrimpTimeManager.current()
	while !isPressed(action):
		await ShrimpTimeManager.frame()
		if ShrimpTimeManager.current() - start >= timeout:
			return timeout
	return ShrimpTimeManager.current() - start
func release(action: SemanticAction, timeout: float = INF) -> float:
	if !isPressed(action): return 0
	var start = ShrimpTimeManager.current()
	while isPressed(action):
		await ShrimpTimeManager.frame()
		if ShrimpTimeManager.current() - start >= timeout:
			return timeout
	return ShrimpTimeManager.current() - start
func hold(action: SemanticAction, duration: float) -> float:
	var time = await release(action, duration)
	return time if time >= duration else 0.0
func isPressed(action: SemanticAction) -> bool:
	if !action.canPress(): return false
	return action.isPressed()
