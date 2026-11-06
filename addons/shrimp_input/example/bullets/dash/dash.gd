extends ExampleShrimpBaseBullet

func ai(delta: float) -> void:
	position = launcher.position
	rotation = lerp_angle(rotation, launcher.linear_velocity.angle(), delta * 10)
func getBaseDamage(entity: ExampleShrimpBaseEntity) -> float:
	return max(1, sqrt((entity.getMomentum() - launcher.getMomentum()).length()))
