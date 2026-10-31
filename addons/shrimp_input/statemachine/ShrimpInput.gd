extends Node
class_name ShrimpInput

var charging: Dictionary[SemanticAction, float] = {} # action->开始时间戳

func press(action: SemanticAction, timeout: float = INF) -> float:
	var start = currentTick()
	while !isPressed(action):
		await frame()
		if currentTick() - start >= timeout:
			return timeout
	return currentTick() - start
func release(action: SemanticAction, timeout: float = INF) -> float:
	if !isPressed(action): return 0
	var start = currentTick()
	while isPressed(action):
		await frame()
		if currentTick() - start >= timeout:
			return timeout
	return currentTick() - start
func hold(action: SemanticAction, minTime: float) -> float:
	var time = await release(action, minTime)
	return time if time >= minTime else 0.0
func charge(action: SemanticAction, maxTime: float) -> bool:
	if !charging.has(action):
		charging[action] = currentTick()
	var state = currentTick() - charging[action] <= maxTime
	if !state:
		charging.erase(action)
	return state
func isPressed(action: SemanticAction) -> bool:
	if !action.canPress(): return false
	return action.isPressed()
func frame() -> float:
	return await ShrimpTimeManager.frame(self)
func currentTick() -> float:
	return ShrimpTimeManager.current(self)
