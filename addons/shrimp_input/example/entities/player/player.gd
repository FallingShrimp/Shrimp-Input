extends ExampleShrimpBaseEntity

const BULLET = preload("res://addons/shrimp_input/example/bullets/shrimp/shrimp.tscn")
const MAX_CHARGE = 2.0
var Actions = ExampleShrimpActions

@onready var input: ShrimpInput = $%ShrimpInput
@onready var charge: ExampleShrimpChargeRing = $%ChargeRing

func _ready() -> void:
	inputLoop()
	dashLoop()
	charge.hide()
	add_child(Actions.ATTACK)
func _physics_process(_delta: float) -> void:
	apply_central_force(getInputDirection() * 3000)

func getInputDirection() -> Vector2:
	return input.direction(
		Actions.MOVE_UP,
		Actions.MOVE_DOWN,
		Actions.MOVE_LEFT,
		Actions.MOVE_RIGHT
	)
func dashLoop():
	while true:
		await input.clock.frame()
		await input.press(Actions.DASH)
		var dir = getInputDirection()
		if !dir.length():
			dir = Actions.ATTACK.getPosition() - position
		apply_central_impulse(dir.normalized() * 5000)
		await input.clock.seconds(0.5)
		await input.release(Actions.DASH)
func inputLoop():
	while true:
		await input.clock.frame()
		await input.press(Actions.ATTACK)
		shoot(10)
		if await input.hold(Actions.ATTACK, 0.2):
			charge.maxValue = MAX_CHARGE
			charge.show()
			var hold = 0
			while input.charge(Actions.ATTACK, MAX_CHARGE):
				hold += await input.clock.frame()
				charge.value = hold
			await input.release(Actions.ATTACK)
			shoot(10 + hold / MAX_CHARGE * 50)
			charge.hide()
			charge.value = 0
		await input.clock.seconds(0.3)
		await input.release(Actions.ATTACK)
func shoot(damage: float):
	var b = BULLET.instantiate() as ExampleShrimpBaseBullet
	b.launcher = self
	b.damage = damage
	b.knockback *= damage / 10
	b.position = position
	b.rotation = position.angle_to_point(Actions.ATTACK.getPosition())
	get_parent().add_child.call_deferred(b)
