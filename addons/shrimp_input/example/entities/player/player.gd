extends ExampleShrimpBaseEntity

const SHRIMP_BULLET = preload("res://addons/shrimp_input/example/bullets/shrimp/shrimp.tscn")
const FIRESHRIMP_BULLET = preload("res://addons/shrimp_input/example/bullets/fire-shrimp/fire-shrimp.tscn")
const DASH_BULLET = preload("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")
const MAX_CHARGE = 2.0
var Actions = ExampleShrimpActions

@onready var input: ShrimpInput = $%ShrimpInput
@onready var charge: ExampleShrimpChargeRing = $%ChargeRing

func _ready() -> void:
	super._ready()
	inputLoop()
	dashLoop()
	charge.hide()
	add_child(Actions.ATTACK)
	add_to_group("player")
	for i in 10:
		var enemy = ENEMY.instantiate() as ExampleShrimpBaseEntity
		enemy.position = Vector2.from_angle(randf() * TAU) * randf_range(0, 1000)
		get_tree().root.add_child.call_deferred(enemy)
func _physics_process(_delta: float) -> void:
	apply_central_force(getInputDirection() * 3000)

func getInputDirection() -> Vector2:
	return input.direction(
		Actions.MOVE_UP,
		Actions.MOVE_DOWN,
		Actions.MOVE_LEFT,
		Actions.MOVE_RIGHT
	)
func getMouseAngle() -> float:
	return position.angle_to_point(Actions.ATTACK.getPosition())
func dashLoop():
	while true:
		await input.clock.frame()
		await input.press(Actions.DASH)
		var dir = getInputDirection()
		if !dir.length():
			dir = Vector2.from_angle(getMouseAngle())
		apply_central_impulse(dir.normalized() * 2500)
		await input.clock.seconds(0.5)
		await input.release(Actions.DASH)
func inputLoop():
	while true:
		await input.clock.frame()
		var atk = await input.presses([Actions.STAB, Actions.ATTACK])
		# if atk == Actions.STAB:
		# 	playSound("Dash")
		# 	input.buffer.consume(2)
		# 	shoot(DASH_BULLET, 20, linear_velocity.angle())
		# elif atk == Actions.ATTACK:
			# playSound("Attack")
			# input.buffer.consume(1)
			# shoot(SHRIMP_BULLET, 10, getMouseAngle())
		playSound("Attack")
		input.buffer.consume(1)
		shoot(SHRIMP_BULLET, 10, getMouseAngle())
		if await input.hold(Actions.ATTACK, 0.2):
			charge.maxValue = MAX_CHARGE
			charge.show()
			var hold = 0
			while input.charge(Actions.ATTACK, MAX_CHARGE):
				hold += await input.clock.frame()
				charge.value = hold
			await input.release(Actions.ATTACK)
			playSound("HeavyShot")
			shoot(FIRESHRIMP_BULLET, 10 + hold / MAX_CHARGE * 50, getMouseAngle())
			charge.hide()
			charge.value = 0
		await input.clock.seconds(0.3)
		await input.release(Actions.ATTACK)
