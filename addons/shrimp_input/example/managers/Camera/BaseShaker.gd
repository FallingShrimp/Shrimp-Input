@abstract
extends RefCounted
class_name ExampleShrimpBaseShaker

var indensity: float
var duration: float
var spawnWhen: float

func _init(indensityX: float, durationX: float) -> void:
	indensity = indensityX
	duration = durationX

@abstract
func shake(camera: ExampleShrimpCameraManager, delta: float) -> Vector2
