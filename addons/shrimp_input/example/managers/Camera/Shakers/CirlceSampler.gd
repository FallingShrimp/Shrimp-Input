extends ExampleShrimpBaseShaker
class_name ExampleShrimpCircleSampler

func shake(_camera: ExampleShrimpCameraManager, _delta: float) -> Vector2:
	return Vector2.from_angle(randf() * TAU) * randf() * indensity
