extends Area2D
class_name ExampleShrimpBaseBullet

enum BulletState {
	LIVING,
	DIEING
}

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

@onready var animator: AnimationPlayer = $%Animator
var spawnWhen: float = 0
var state: BulletState = BulletState.LIVING
var launcher: ExampleShrimpBaseEntity

func _ready() -> void:
	body_entered.connect(hitTest)
	spawnWhen = ShrimpTimeManager.current(self)
func _process(_delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	if state == BulletState.LIVING:
		if !is_instance_valid(launcher) || timeLived() > lifeTime || damage < 1:
			goDie()
		else:
			ai(delta)

func ai(_delta: float) -> void:
	pass
func onDie():
	await ShrimpTimeManager.frame(self)

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
			var total = damage * launcher.damageFactor * (1 + randf_range(-1, 1) * 0.2)
			if crit:
				total *= 2 + max(launcher.critRate - 0.85, 0) * 2
			body.hurt(total, crit, self)
			body.apply_central_impulse((body.position - position).normalized() * knockback)
			launcher.apply_central_impulse((position - body.position).normalized() * recoil)
			if reflect + launcher.reflect > 0:
				var e = ExampleShrimpBaseEntity.closet(self, func(i: ExampleShrimpBaseEntity): return i != body)
				if is_instance_valid(e):
					rotation = position.angle_to_point(e.position)
				else:
					rotation = randf() * TAU
				reflect -= 1
