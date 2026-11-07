extends ExampleShrimpBaseEffect

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.start()

func attached(entity: ExampleShrimpBaseEntity):
	entity.texture.modulate *= Color.RED
	timer.timeout.connect(
		func():
			entity.hurt(layer * 0.25, false)
			entity.consumeEffect(get_script())
	)
func detached(entity: ExampleShrimpBaseEntity):
	entity.texture.modulate /= Color.RED
func update(_entity: ExampleShrimpBaseEntity, _delta: float):
	timer.wait_time = 0.3 / (1 + 0.25 * layer)
