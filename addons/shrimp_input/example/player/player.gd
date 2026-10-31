extends RigidBody2D

@onready var input: ShrimpInput = $%ShrimpInput
var actions = preload("res://addons/shrimp_input/example/actions.gd").new()
var bullet = preload("res://addons/shrimp_input/example/bullet/bullet.tscn")

func _ready() -> void:
	inputLoop()
func _physics_process(_delta: float) -> void:
	var dir = Input.get_vector(
		actions.MOVE_LEFT.inputEvent,
		actions.MOVE_RIGHT.inputEvent,
		actions.MOVE_UP.inputEvent,
		actions.MOVE_DOWN.inputEvent
	)
	apply_central_force(dir * 3000)

func inputLoop():
	while true:
		await ShrimpTimeManager.frame(self)
		await input.press(actions.ATTACK)
		var b = bullet.instantiate() as Area2D
		b.position = position
		b.rotation = position.angle_to_point(get_global_mouse_position())
		get_parent().add_child.call_deferred(b)
		await ShrimpTimeManager.seconds(0.3, self)
