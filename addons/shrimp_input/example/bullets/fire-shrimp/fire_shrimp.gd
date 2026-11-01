extends ExampleShrimpBaseBullet

func ai(delta: float) -> void:
	position += Vector2.from_angle(rotation) * speed * delta
