extends ExampleShrimpBaseEffect

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 0.5
	add_child(timer)
	timer.start()

func attached(entity: ExampleShrimpBaseEntity):
	entity.texture.modulate *= Color.BLUE
	timer.timeout.connect(
		func():
			entity.hurt(0.5 * layer, false)
			entity.consumeEffect(get_script())
	)
func detached(entity: ExampleShrimpBaseEntity):
	entity.texture.modulate /= Color.BLUE
func provideStats() -> Dictionary[StatsDB.Stats, ValueModifier]:
	return {
		StatsDB.Stats.MOVEMENT_SPEED: ValueModifier.new(ValueModifier.Operation.MULTIPLY, 1 / (1 + 0.25 * layer)),
		StatsDB.Stats.VULNERABILITY: ValueModifier.new(ValueModifier.Operation.ADD, 0.05 * layer)
	}
