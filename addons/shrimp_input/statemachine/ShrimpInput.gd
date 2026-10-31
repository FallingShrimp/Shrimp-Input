extends Node
class_name ShrimpInput

var clock: ShrimpClock
var charging: Dictionary[SemanticAction, float] = {} # action->开始时间戳

func _ready() -> void:
	clock = ShrimpClock.new()
	add_child(clock)

func press(action: SemanticAction, timeout: float = INF) -> float:
	var start = clock.currentTick()
	while !isPressed(action):
		await clock.frame()
		if clock.currentTick() - start >= timeout:
			return timeout
	return clock.currentTick() - start
func release(action: SemanticAction, timeout: float = INF) -> float:
	if !isPressed(action): return 0
	var start = clock.currentTick()
	while isPressed(action):
		await clock.frame()
		if clock.currentTick() - start >= timeout:
			return timeout
	return clock.currentTick() - start
func hold(action: SemanticAction, minTime: float) -> float:
	var time = await release(action, minTime)
	return time if time >= minTime else 0.0
func charge(action: SemanticAction, maxTime: float) -> bool:
	if !charging.has(action):
		charging[action] = clock.currentTick()
	var state = isPressed(action) && clock.currentTick() - charging[action] <= maxTime + ShrimpTimeManager.getInstance(self).lastDelta
	if !state:
		charging.erase(action)
	return state
func isPressed(action: SemanticAction) -> bool:
	if !action.canPress(): return false
	return action.isPressed()
