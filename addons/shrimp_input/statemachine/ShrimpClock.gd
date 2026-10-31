extends Node
class_name ShrimpClock

const ERR_NO_CLOCK = "Please add a ShrimpClock below the input node."

var __scale__: float = 1
var tickAnchor: float = 0
var virtualAnchor: float = 0
var timeScale: float:
	get:
		return __scale__
	set(value):
		virtualAnchor = now()
		tickAnchor = currentTick()
		__scale__ = value

func _ready() -> void:
	reset()

func reset() -> void:
	tickAnchor = currentTick()
	virtualAnchor = 0.0
func now() -> float:
	return virtualAnchor + (currentTick() - tickAnchor) * timeScale
func toTick(virtual: float) -> float:
	return tickAnchor + (virtual - virtualAnchor) / timeScale
func currentTick() -> float:
	return ShrimpTimeManager.current(self)
func frame() -> float:
	return await ShrimpTimeManager.frame(self) * timeScale
func seconds(duration: float):
	await get_tree().create_timer(duration / timeScale).timeout

static func findIn(node: Node) -> ShrimpClock:
	for i in node.get_children():
		if i is ShrimpClock:
			return i
	assert(false, ERR_NO_CLOCK)
	return null
