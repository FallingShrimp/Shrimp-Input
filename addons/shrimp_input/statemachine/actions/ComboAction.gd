extends SemanticAction
class_name ComboAction

var combo: Array[StringName] = []

func _init(comboX: Array[StringName], parent: SemanticAction = null) -> void:
	combo = comboX
	super._init("", parent)

func isPressed(inputNode: ShrimpInput) -> bool:
	if is_instance_valid(inputNode.buffer):
		return inputNode.buffer.count(combo) != -1
	else:
		return false
