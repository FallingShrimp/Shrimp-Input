extends Area2D

const blood = preload("res://addons/shrimp_input/example/blood_effect/blood_effect.tscn")

enum BulletState {
	LIVING,
	DIEING
}

@onready var animator: AnimationPlayer = $%Animator
@onready var rotator: AnimationPlayer = $%Rotate
var state: BulletState = BulletState.LIVING

func _ready() -> void:
	body_entered.connect(hittest)
func _physics_process(delta: float) -> void:
	if state == BulletState.LIVING:
		position += Vector2.from_angle(rotation) * 700 * delta

func hittest(body):
	if state != BulletState.LIVING: return
	if body is StaticBody2D:
		if body.is_in_group("wall"):
			state = BulletState.DIEING
			var effect = blood.instantiate() as GPUParticles2D
			effect.emitting = true
			add_child(effect)
			effect.global_rotation = 0
			rotator.stop(true)
			animator.play("die")
			await animator.animation_finished
			queue_free()
