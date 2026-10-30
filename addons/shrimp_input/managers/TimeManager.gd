@tool
extends Node
class_name ShrimpTimeManager

static var instance: ShrimpTimeManager

var timeLived: float = 0

func _ready() -> void:
	instance = self
func _process(delta: float) -> void:
	timeLived += delta

static func current() -> float:
	return instance.timeLived
