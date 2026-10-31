extends Node
class_name ShrimpInput

@export var clock: ShrimpClock = null
var buffer: ShrimpBuffer
var charging: Dictionary[SemanticAction, float] = {} # action->开始时间戳

func _ready() -> void:
	if !is_instance_valid(clock):
		clock = ShrimpClock.findIn(self)
	buffer = ShrimpBuffer.findIn(self, false)

func press(action: SemanticAction, timeout: float = INF) -> float:
	var start = clock.currentTick()
	while !isPressed(action):
		await clock.frame()
		if clock.currentTick() - start >= timeout:
			return timeout
	return clock.currentTick() - start
func presses(actions: Array[SemanticAction], timeout: float = INF) -> SemanticAction:
	var start = clock.currentTick()
	while clock.currentTick() - start < timeout:
		await clock.frame()
		for action in actions:
			if isPressed(action):
				return action
	return null
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
func direction(up: SemanticAction, down: SemanticAction, left: SemanticAction, right: SemanticAction):
	return ([
		Vector2(0, -1) * int(isPressed(up)),
		Vector2(0, 1) * int(isPressed(down)),
		Vector2(-1, 0) * int(isPressed(left)),
		Vector2(1, 0) * int(isPressed(right)),
	].reduce(func(a, b): return a + b, Vector2.ZERO) as Vector2).normalized()
func isPressed(action: SemanticAction) -> bool:
	if !action.canPress(): return false
	return action.isPressed(self)
