@tool
extends Node
class_name ShrimpTimeManager

var timeLived: float = 0
var lastDelta: float = 0

func _process(delta: float) -> void:
	lastDelta = delta
	timeLived += delta

static func getInstance(from: Node) -> ShrimpTimeManager:
	return from.get_tree().root.get_node(ShrimpInputPlugin.TIME_MANAGER)
static func current(from: Node) -> float:
	return getInstance(from).timeLived
static func frame(from: Node) -> float:
	await from.get_tree().process_frame
	return getInstance(from).lastDelta
static func seconds(duration: float, from: Node):
	return await from.get_tree().create_timer(duration).timeout
