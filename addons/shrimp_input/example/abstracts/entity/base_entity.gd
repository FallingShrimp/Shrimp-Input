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
