extends RigidBody2D
class_name ExampleShrimpBaseEntity

@export var health: float = 100

@onready var healthLabel: Label = $%Health

func _process(_delta: float) -> void:
	healthLabel.text = str(health)
