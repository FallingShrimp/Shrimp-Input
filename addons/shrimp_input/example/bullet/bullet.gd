extends Area2D

func _physics_process(delta: float) -> void:
	position += Vector2.from_angle(rotation) * 500 * delta
