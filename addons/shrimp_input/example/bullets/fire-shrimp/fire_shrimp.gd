extends ExampleShrimpBaseBullet

const BURN_EFFECT = preload("res://addons/shrimp_input/example/effects/burn.gd")

func ai(delta: float) -> void:
	position += Vector2.from_angle(rotation) * speed * delta
func hit(entity: ExampleShrimpBaseEntity):
	entity.attachEffect(BURN_EFFECT, 5)
