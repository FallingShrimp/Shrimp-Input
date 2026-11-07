extends ExampleShrimpBaseEffect

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 0.2
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
func provideStats() -> Dictionary[StatsDB.Stats, ValueModifier]:
	return {
		StatsDB.Stats.VULNERABILITY: ValueModifier.new(ValueModifier.Operation.ADD, 0.05 * layer)
	}
