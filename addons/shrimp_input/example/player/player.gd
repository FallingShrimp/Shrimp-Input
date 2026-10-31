extends RigidBody2D

const BULLET = preload("res://addons/shrimp_input/example/BULLET/BULLET.tscn")
const MAX_CHARGE = 2.0

@onready var input: ShrimpInput = $%ShrimpInput
@onready var charge: ExampleShrimpChargeRing = $%ChargeRing
var actions = preload("res://addons/shrimp_input/example/actions.gd").new()

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
		await input.clock.frame()
		await input.press(actions.ATTACK)
		shoot(10)
		if await input.hold(actions.ATTACK, 0.2):
			charge.maxValue = MAX_CHARGE
			var hold = 0
			while input.charge(actions.ATTACK, MAX_CHARGE):
				hold += await input.clock.frame()
				charge.value = hold
			shoot(10 + hold / MAX_CHARGE * 50)
			charge.value = 0
		await input.clock.seconds(0.3)
		await input.release(actions.ATTACK)
func shoot(damage: float):
	var b = BULLET.instantiate() as ExampleShrimpBullet
	b.damage = damage
	b.position = position
	b.rotation = position.angle_to_point(get_global_mouse_position())
	get_parent().add_child.call_deferred(b)
