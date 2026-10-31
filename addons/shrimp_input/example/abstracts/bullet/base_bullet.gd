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
@export var lifeTime: float = 1

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
		ai(delta)
		if timeLived() > lifeTime:
			goDie()

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
	if body is StaticBody2D:
		if body.is_in_group("wall"):
			goDie()
	elif body is ExampleShrimpBaseEntity:
		if launcher.stance != body.stance:
			body.health -= damage
			body.apply_central_impulse((body.position - position).normalized() * knockback)
			var dmg = DAMAGE.instantiate() as ExampleShrimpBaseBullet
			dmg.damage = damage
			dmg.position = position
			get_tree().root.add_child.call_deferred(dmg)
			goDie()
