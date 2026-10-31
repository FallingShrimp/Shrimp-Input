@tool
extends Node
class_name ShrimpBuffer

const ERR_NOT_FOUND = "Please add a ShrimpBuffer below the node."

class BufferedActionNode extends RefCounted:
	var action: StringName
	var spawnTick: float

@export var clock: ShrimpClock
@export var maxLength: int = 10
@export var actionLifetime: float = 0.35
@export_storage var handleActions: Array[StringName] = []

var stack: Array[BufferedActionNode] = []
var head: int = 0
var tail: int = 0
var currentLength: int = 0

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if !is_instance_valid(clock):
		clock = ShrimpClock.findIn(self)
	stack.resize(maxLength)
	for i in maxLength:
		stack[i] = BufferedActionNode.new()
func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	for action in handleActions:
		if Input.is_action_just_pressed(action):
			push(action)
func _get_property_list() -> Array[Dictionary]:
	return [
		{
			"name": "handleActions",
			"type": TYPE_ARRAY,
			"hint": PROPERTY_HINT_TYPE_STRING,
			"hint_string": "%d/%d:%s" % [
				TYPE_STRING_NAME,
				PROPERTY_HINT_ENUM,
				",".join(
					ProjectSettings.get_property_list()
						.map(func(e: Dictionary): return e.name)
						.filter(func(n: String): return n.begins_with("input/"))
						.map(func(n: String): return n.substr(6))
						.filter(func(n: String): return !n.begins_with("ui_"))
				)
			],
			"usage": PROPERTY_USAGE_SCRIPT_VARIABLE | PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE,
			"default": []
		}
	]

func push(action: StringName) -> void:
	var hair = (head + 1) % maxLength
	if currentLength == maxLength:
		tail = (tail + 1) % maxLength
	else:
		currentLength += 1
	stack[head].action = action
	stack[head].spawnTick = clock.currentTick()
	head = hair
func count(inputEvents: Array[StringName], lifetimeOverride: float = -1.0) -> int:
	if inputEvents.is_empty():
		return -1
	if lifetimeOverride <= 0:
		lifetimeOverride = actionLifetime
	var startTime = clock.currentTick()
	var result = 0
	var pointer = tail
	for i in currentLength:
		var item = stack[pointer]
		pointer = (pointer + 1) % maxLength
		if startTime - item.spawnTick > lifetimeOverride:
			continue
		if item.action == inputEvents[result]:
			result += 1
			if result == len(inputEvents):
				return result
		elif item.action == inputEvents[0]:
			result = 1
		else:
			result = 0
	return -1
func consume(length: int) -> void:
	for i in min(length, currentLength):
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
