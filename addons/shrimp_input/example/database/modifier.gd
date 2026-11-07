extends RefCounted
class_name ValueModifier

enum Operation {
	ADD,
	MULTIPLY,
	EXP
}

var operation: Operation
var value: float
var next: ValueModifier

func _init(operationX: Operation, valueX: float) -> void:
	operation = operationX
	value = valueX

func modify(base: float) -> float:
	var result: float = base
	match operation:
		Operation.ADD:
			result += value
		Operation.MULTIPLY:
			result *= value
		Operation.EXP:
			result **= value
	if is_instance_valid(next):
		return next.modify(result)
	else:
		return result
func append(modifier: ValueModifier):
	if is_instance_valid(next):
		next.append(modifier)
	else:
		next = modifier

static func empty() -> ValueModifier:
	return ValueModifier.new(Operation.ADD, 0)
static func fromChain(chain: Array) -> ValueModifier:
	if len(chain) == 0:
		return empty()
	else:
		var result = empty()
		for modifier in chain:
			result.append(modifier)
		return result
