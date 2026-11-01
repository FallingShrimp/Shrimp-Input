extends ExampleShrimpBaseEntity
class_name ExampleShrimpPlayer

const MAX_CHARGE = 2.0

@onready var input: ShrimpInput = $%ShrimpInput
@onready var charge: ExampleShrimpChargeRing = $%ChargeRing
@onready var dashTrail: GPUParticles2D = $%DashTrail
@onready var dashProgress: ProgressBar = $%DashProgress
var SHRIMP_BULLET = load("res://addons/shrimp_input/example/bullets/shrimp/shrimp.tscn")
var FIRESHRIMP_BULLET = load("res://addons/shrimp_input/example/bullets/fire-shrimp/fire-shrimp.tscn")
var DASH_BULLET = load("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
var DASH_COOLDOWN = 0.5
var DASH_INVINCIBLE = 0.3
var regeneration: float = 0
var lucky: float = 0
var attackSpeed: float = 1
var scoreMult: float = 1

func _ready() -> void:
	super._ready()
	inputLoop()
	dashLoop()
	charge.hide()
	add_child(Actions.ROOT_ACTION)
	add_to_group("player")
	dashProgress.value = 1
func ai(delta: float) -> void:
	apply_central_force(getInputDirection() * 3000)
	if health < initialHealth:
		health += regeneration * delta

func defocus(state: bool):
	set_collision_mask_value(1, !state)
	set_collision_layer_value(1, !state)
	invincible = state
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
		playSound("Dash")
		for d in [shoot(DASH_BULLET, 10, dir.angle())]:
			if d is ExampleShrimpBaseBullet:
				d.lifeTime = DASH_INVINCIBLE
				d.scale *= 2
		dashProgress.value = 0
		dashTrail.emitting = true
		defocus(true)
		var hold = 0
		while input.charge(Actions.ROOT_ACTION, DASH_INVINCIBLE):
			hold += await input.clock.frame()
			dashProgress.value = 1 - hold / DASH_INVINCIBLE
		defocus(false)
		dashTrail.emitting = false
		hold = 0
		while input.charge(Actions.ROOT_ACTION, DASH_COOLDOWN):
			hold += await input.clock.frame()
			dashProgress.value = hold / DASH_COOLDOWN
		await input.release(Actions.DASH)
func inputLoop():
	while true:
		input.clock.timeScale = attackSpeed
		await input.clock.frame()
		await input.press(Actions.ATTACK)
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
			if hold >= MAX_CHARGE:
				playSound("Charged")
			await input.release(Actions.ATTACK)
			playSound("HeavyShot")
			shoot(FIRESHRIMP_BULLET, 10 + hold / MAX_CHARGE * 50, getMouseAngle())
			charge.hide()
			charge.value = 0
		await input.clock.seconds(0.3)
		await input.release(Actions.ATTACK)
