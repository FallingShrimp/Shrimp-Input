extends ExampleShrimpBaseBullet

const FROZEN_EFFECT = preload("res://addons/shrimp_input/example/effects/frozen/frozen.gd")

func ai(delta: float) -> void:
	position += Vector2.from_angle(rotation) * speed * delta
func hit(entity: ExampleShrimpBaseEntity):
	entity.attachEffect(FROZEN_EFFECT, 6)
