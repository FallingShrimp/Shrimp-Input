extends SemanticAction
class_name ComboAction

var combo: Array[StringName] = []

func _init(comboX: Array[StringName]) -> void:
	combo = comboX

func isPressed(inputNode: ShrimpInput) -> bool:
	if is_instance_valid(inputNode.buffer):
		return inputNode.buffer.count(combo) != -1
	else:
		return false
