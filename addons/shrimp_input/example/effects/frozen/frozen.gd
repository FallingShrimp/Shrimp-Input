extends ExampleShrimpBaseEffect

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.start()

func attached(entity: ExampleShrimpBaseEntity):
	entity.modulate *= Color.BLUE
	timer.timeout.connect(func(): entity.hurt(10 + 2 * layer, false))
func detached(entity: ExampleShrimpBaseEntity):
	entity.modulate /= Color.BLUE
func provideStats() -> Dictionary[StatsDB.Stats, ValueModifier]:
	return {
		StatsDB.Stats.MOVEMENT_SPEED: ValueModifier.new(ValueModifier.Operation.MULTIPLY, 0.1)
	}
func update(_entity: ExampleShrimpBaseEntity, _delta: float):
	timer.wait_time = 1.0 / (1 + 0.2 * layer)
