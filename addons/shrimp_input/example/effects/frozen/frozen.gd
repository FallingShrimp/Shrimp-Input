extends ExampleShrimpBaseEffect

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 0.5
	add_child(timer)
	timer.start()

func attached(entity: ExampleShrimpBaseEntity):
	entity.modulate *= Color.BLUE
	timer.timeout.connect(
		func():
			entity.hurt(3 * layer, false)
			entity.consumeEffect(get_script())
	)
func detached(entity: ExampleShrimpBaseEntity):
	entity.modulate /= Color.BLUE
func provideStats() -> Dictionary[StatsDB.Stats, ValueModifier]:
	return {
		StatsDB.Stats.MOVEMENT_SPEED: ValueModifier.new(ValueModifier.Operation.MULTIPLY, 0.1)
	}
