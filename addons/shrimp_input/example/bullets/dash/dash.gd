extends ExampleShrimpBaseBullet

func ai(delta: float) -> void:
	position = launcher.position
	rotation = lerp_angle(rotation, launcher.linear_velocity.angle(), delta * 10)
	damage = max(1, sqrt(launcher.linear_velocity.length()))
