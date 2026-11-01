extends Area2D
class_name ExampleShrimpBaseBullet

const DAMAGE = preload("res://addons/shrimp_input/example/bullets/damage/damage.tscn")

enum BulletState {
	LIVING,
	DIEING
}

@export var damage: float = 10
@export var speed: float = 500
@export var knockback: float = 0
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
		if body.is_in_group("wall"):
			if bounce > 0:
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
		if !body.invincible && launcher.stance != body.stance:
			var total = damage * launcher.damageFactor
			body.health -= total
			body.apply_central_impulse((body.position - position).normalized() * knockback)
			body.playSound("Hurt")
			if body.health <= 0:
				body.goDie()
			var dmg = DAMAGE.instantiate() as ExampleShrimpBaseBullet
			dmg.damage = total
			dmg.position = position
			get_tree().root.add_child.call_deferred(dmg)
			damage *= penetrate
			if reflect > 0:
				var e = ExampleShrimpBaseEntity.closet(self, func(i: ExampleShrimpBaseEntity): return i != body)
				if is_instance_valid(e):
					rotation = position.angle_to_point(e.position)
				else:
					rotation = randf() * TAU
				reflect -= 1
