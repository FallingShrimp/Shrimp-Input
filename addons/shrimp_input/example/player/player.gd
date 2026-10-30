extends RigidBody2D
class_name Player

var actions = preload("res://addons/shrimp_input/example/actions.gd").new()

func _physics_process(_delta: float) -> void:
	var dir = Input.get_vector(
		actions.MOVE_LEFT.inputEvent,
		actions.MOVE_RIGHT.inputEvent,
		actions.MOVE_UP.inputEvent,
		actions.MOVE_DOWN.inputEvent
	)
	apply_central_force(dir * 3000)
