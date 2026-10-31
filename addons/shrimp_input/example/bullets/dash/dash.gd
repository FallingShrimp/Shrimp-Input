extends ExampleShrimpBaseBullet

func ai(_delta: float) -> void:
	position = launcher.position
	rotation = launcher.linear_velocity.angle()
	damage = sqrt(launcher.linear_velocity.length())
