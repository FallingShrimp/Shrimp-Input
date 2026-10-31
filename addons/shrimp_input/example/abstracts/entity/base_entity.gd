extends RigidBody2D
class_name ExampleShrimpBaseEntity

enum Stance {
	PLAYER,
	ENEMY
}

@export var health: float = 100
@export var stance: Stance = Stance.ENEMY

@onready var healthLabel: Label = $%Health

func _process(_delta: float) -> void:
	healthLabel.text = str(health)

func shoot(bullet: PackedScene, damage: float, rotationX: float = 0):
	var instance = bullet.instantiate() as ExampleShrimpBaseBullet
	instance.launcher = self
	instance.damage = damage
	instance.knockback *= damage / 10
	instance.position = position
	instance.rotation = rotationX
	get_parent().add_child.call_deferred(instance)
