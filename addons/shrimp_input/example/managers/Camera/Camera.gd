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
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					zoom *= 1.1
				MOUSE_BUTTON_WHEEL_DOWN:
					zoom *= 0.9

static func addShake(shaker: ExampleShrimpBaseShaker):
	shaker.spawnWhen = instance.clock.currentTick()
	instance.shakers.append(shaker)
