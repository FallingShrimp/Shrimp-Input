extends Area2D
class_name ExampleShrimpBaseBullet

const BLOOD = preload("res://addons/shrimp_input/example/blood_effect/blood_effect.tscn")

enum BulletState {
	LIVING,
	DIEING
}

@export var damage: float = 10
@export var speed: float = 500

@onready var animator: AnimationPlayer = $%Animator
var state: BulletState = BulletState.LIVING
var launcher: ExampleShrimpBaseEntity

func _ready() -> void:
	body_entered.connect(hitTest)
func _process(_delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	if state == BulletState.LIVING:
		ai(delta)

func ai(_delta: float) -> void:
	pass
func onDie():
	await ShrimpTimeManager.frame(self)

func goDie():
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
			goDie()
