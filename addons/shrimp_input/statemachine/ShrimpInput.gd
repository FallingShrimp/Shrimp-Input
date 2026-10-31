extends Node
class_name ShrimpInput

func press(action: SemanticAction, timeout: float = INF) -> float:
	var start = ShrimpTimeManager.current(self)
	while !isPressed(action):
		await ShrimpTimeManager.frame(self)
		if ShrimpTimeManager.current(self) - start >= timeout:
			return timeout
	return ShrimpTimeManager.current(self) - start
func release(action: SemanticAction, timeout: float = INF) -> float:
	if !isPressed(action): return 0
	var start = ShrimpTimeManager.current(self)
	while isPressed(action):
		await ShrimpTimeManager.frame(self)
		if ShrimpTimeManager.current(self) - start >= timeout:
			return timeout
	return ShrimpTimeManager.current(self) - start
func hold(action: SemanticAction, duration: float) -> float:
	var time = await release(action, duration)
	return time if time >= duration else 0.0
func isPressed(action: SemanticAction) -> bool:
	if !action.canPress(): return false
	return action.isPressed()
