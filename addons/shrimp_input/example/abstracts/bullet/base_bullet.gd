extends Area2D
class_name ExampleShrimpBaseBullet

const DEFENSE_FACTOR = 100

enum BulletState {
	LIVING,
	DIEING
}

@export var autoGoDie: bool = true
@export var ignoreWall: bool = false
@export var damage: float = 10
@export var speed: float = 500
@export var knockback: float = 0
@export var recoil: float = 0
@export var launchRecoil: float = 0
@export var lifeTime: float = INF
@export var penetrate: float = 1
@export var bounce: float = INF
@export var reflect: float = INF
@export var lockRotation: bool = false

@onready var animator: AnimationPlayer = $%Animator
var spawnWhen: float = 0
var spawnFacing: float = 0
var state: BulletState = BulletState.LIVING
var launcher: ExampleShrimpBaseEntity

func _ready() -> void:
	body_entered.connect(hitTest)
	spawnWhen = ShrimpTimeManager.current(self)
	spawnFacing = rotation
func _process(_delta: float) -> void:
	if lockRotation:
		rotation = spawnFacing
func _physics_process(delta: float) -> void:
	if state == BulletState.LIVING:
		if autoGoDie && (!is_instance_valid(launcher) || timeLived() > lifeTime || damage < 1):
			goDie()
		else:
			ai(delta)

func ai(_delta: float) -> void:
	pass
func onDie():
	await ShrimpTimeManager.frame(self)
func getBaseDamage(_entity: ExampleShrimpBaseEntity) -> float:
	return damage
func overrideDamage(original: float, _entity: ExampleShrimpBaseEntity) -> float:
	return original * 1.0

func timeLived() -> float:
	return ShrimpTimeManager.current(self) - spawnWhen
func goDie():
	if state == BulletState.DIEING: return
	state = BulletState.DIEING
	await onDie()
	queue_free()
func hitTest(body):
	if state != BulletState.LIVING: return
	if !is_instance_valid(launcher): return
	if body is StaticBody2D:
		if !ignoreWall && body.is_in_group("wall"):
			if bounce + launcher.bounce > 0:
				var e = ExampleShrimpBaseEntity.closet(self)
				if is_instance_valid(e):
					rotation = position.angle_to_point(e.position)
				else:
					rotation += PI
					rotation += randf_range(-1, 1) * deg_to_rad(10)
				bounce -= 1
			else:
				goDie()
	elif body is ExampleShrimpBaseEntity:
		if launcher.stance != body.stance:
			var rate = launcher.critRate
			if launcher is ExampleShrimpPlayer:
				rate += launcher.lucky * 0.015
			var crit = randf() < rate
			var totalDamage = getBaseDamage(body) * launcher.damageFactor * (1 + randf_range(-1, 1) * 0.2)
			if crit:
				totalDamage *= 2 + max(launcher.critRate - 0.85, 0) * 2
			var dedmgMult = ((DEFENSE_FACTOR + (body.defense + int(body.thornsMult > 0)) * (1 + body.thornsMult)) / DEFENSE_FACTOR)
			var defensedDamage = totalDamage / dedmgMult
			totalDamage = overrideDamage(defensedDamage, body)
			var redmg = body.damageFactor * totalDamage * dedmgMult * body.thornsMult
			body.hurt(totalDamage, crit)
			if body is ExampleShrimpPlayer:
				launcher.hurt(redmg, false)
			body.apply_central_impulse((body.position - position).normalized() * knockback * body.mass)
			launcher.apply_central_impulse((position - body.position).normalized() * recoil * launcher.mass)
			if reflect + launcher.reflect > 0:
				var e = ExampleShrimpBaseEntity.closet(self, func(i: ExampleShrimpBaseEntity): return i != body)
				if is_instance_valid(e):
					rotation = position.angle_to_point(e.position)
				else:
					rotation = randf() * TAU
				reflect -= 1
