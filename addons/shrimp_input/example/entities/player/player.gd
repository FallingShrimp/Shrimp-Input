extends ExampleShrimpBaseEntity
class_name ExampleShrimpPlayer

const MAX_CHARGE = 2.0

@onready var attackInput: ShrimpInput = $%AttackInput
@onready var dashInput: ShrimpInput = $%DashInput
@onready var charge: ExampleShrimpChargeRing = $%ChargeRing
@onready var dashTrail: GPUParticles2D = $%DashTrail
@onready var dashProgress: ProgressBar = $%DashProgress
@onready var attackProgress: ProgressBar = $%AttackProgress
var SHRIMP_BULLET = load("res://addons/shrimp_input/example/bullets/shrimp/shrimp.tscn")
var FIRESHRIMP_BULLET = load("res://addons/shrimp_input/example/bullets/fire-shrimp/fire-shrimp.tscn")
var DASH_BULLET = load("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
var DASH_COOLDOWN = 1
var DASH_INVINCIBLE = 0.5
var regeneration: float = 0
var lucky: float = 0
var attackSpeed: float = 1
var scoreMult: float = 1
var dash: float = 1

func _ready() -> void:
	super._ready()
	attackLoop()
	dashLoop()
	charge.hide()
	add_child(Actions.ROOT)
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
	return attackInput.direction(
		Actions.MOVE_UP,
		Actions.MOVE_DOWN,
		Actions.MOVE_LEFT,
		Actions.MOVE_RIGHT
	)
func getMouseAngle() -> float:
	return position.angle_to_point(Actions.ATTACK.getPosition())
func dashLoop():
	while true:
		dashInput.clock.timeScale = dash
		await dashInput.clock.frame()
		await dashInput.press(Actions.DASH)
		var dir = getInputDirection()
		if !dir.length():
			dir = Vector2.from_angle(getMouseAngle())
		apply_central_impulse(dir.normalized() * 2500)
		playSound("Dash")
		var invincibleTime = DASH_COOLDOWN * DASH_INVINCIBLE * dash
		for d in [shoot(DASH_BULLET, 10, dir.angle())]:
			if d is ExampleShrimpBaseBullet:
				d.lifeTime = invincibleTime
				d.lockRotation = true
		dashProgress.value = 0
		dashTrail.emitting = true
		defocus(true)
		var hold = 0
		while dashInput.charge(Actions.ROOT, invincibleTime):
			hold += await dashInput.clock.frame()
			dashProgress.value = 1 - hold / invincibleTime
		defocus(false)
		dashTrail.emitting = false
		hold = 0
		while dashInput.charge(Actions.ROOT, DASH_COOLDOWN):
			hold += await dashInput.clock.frame()
			dashProgress.value = hold / DASH_COOLDOWN
		await dashInput.release(Actions.DASH)
func attackLoop():
	while true:
		attackInput.clock.timeScale = attackSpeed
		await attackInput.clock.frame()
		var hold = 0
		match await attackInput.presses([Actions.HEAVYATTACK, Actions.ATTACK]):
			Actions.ATTACK:
				playSound("Attack")
				attackInput.buffer.consume(1)
				shoot(SHRIMP_BULLET, 10, getMouseAngle())
			Actions.HEAVYATTACK:
				if await attackInput.hold(Actions.HEAVYATTACK, 0.2):
					charge.maxValue = MAX_CHARGE
					charge.show()
					while attackInput.charge(Actions.HEAVYATTACK, MAX_CHARGE):
						hold += await attackInput.clock.frame()
						charge.value = hold
					if hold >= MAX_CHARGE:
						playSound("Charged")
					await attackInput.release(Actions.HEAVYATTACK)
					playSound("HeavyShot")
					shoot(FIRESHRIMP_BULLET, 10 + hold / MAX_CHARGE * 50, getMouseAngle())
					charge.hide()
					charge.value = 0
		hold = 0
		while attackInput.charge(Actions.ROOT, 0.3):
			hold += await attackInput.clock.frame()
			attackProgress.value = 1 - hold / 0.3
