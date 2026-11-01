extends Camera2D
class_name ExampleShrimpCameraManager

static var instance: ExampleShrimpCameraManager

@onready var clock: ShrimpClock = $%Clock
var shakers: Array[ExampleShrimpBaseShaker] = []

func _ready() -> void:
	instance = self
func _physics_process(delta: float) -> void:
	offset = Vector2.ZERO
	var result: Array[ExampleShrimpBaseShaker] = []
	for shaker in shakers:
		offset += shaker.shake(self, delta)
		if clock.currentTick() - shaker.spawnWhen <= shaker.duration:
			result.append(shaker)
	shakers = result

static func addShake(shaker: ExampleShrimpBaseShaker):
	shaker.spawnWhen = instance.clock.currentTick()
	instance.shakers.append(shaker)
