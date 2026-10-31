extends Node
class_name ShrimpBuffer

const ERR_NOT_FOUND = "Please add a ShrimpBuffer below the node."

class BufferItem:
	var event: InputEvent
	var tick: float

@export var maxLength: int = 10
@export var itemLifetime: float = 0.35

var clock: ShrimpClock
var stack: Array[BufferItem] = []
var head: int = 0
var tail: int = 0
var currentLength: int = 0

func _ready() -> void:
	clock = ShrimpClock.findIn(self)
	stack.resize(maxLength)
	for i in maxLength:
		stack[i] = BufferItem.new()

func push(event: InputEvent) -> void:
	if not event.is_pressed(): return
	var hair = (head + 1) % maxLength
	if currentLength == maxLength:
		tail = (tail + 1) % maxLength
	else:
		currentLength += 1
	stack[head].event = event
	stack[head].tick = clock.currentTick()
	head = hair
func count(inputEvents: Array[String], lifetimeOverride: float = -1.0) -> int:
	if inputEvents.is_empty():
		return -1
	if lifetimeOverride <= 0:
		lifetimeOverride = itemLifetime
	var startTime = clock.currentTick()
	var result = 0
	var pointer = tail
	for i in currentLength:
		var item = stack[pointer]
		if startTime - item.tick > lifetimeOverride:
			break
		if item.event.action == inputEvents[result]:
			result += 1
			if result == len(inputEvents):
				return result
		else:
			result = 0
		pointer = (pointer + 1) % maxLength
	return -1
func consume(length: int) -> void:
	for i in range(min(length, currentLength)):
		tail = (tail + 1) % maxLength
		currentLength -= 1
func clear() -> void:
	head = 0
	tail = 0
	currentLength = 0
func getLength() -> int:
	return currentLength

static func findIn(node: Node, asserts: bool = true) -> ShrimpBuffer:
	for i in node.get_children():
		if i is ShrimpBuffer:
			return i
	if asserts:
		assert(false, ERR_NOT_FOUND)
	return null
