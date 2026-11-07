extends ExampleShrimpBaseEffect

func attached(entity: ExampleShrimpBaseEntity):
	entity.modulate *= Color.BLUE
func detached(entity: ExampleShrimpBaseEntity):
	entity.modulate /= Color.BLUE
func provideStats() -> Dictionary[StatsDB.Stats, ValueModifier]:
	return {
		StatsDB.Stats.MOVEMENT_SPEED: ValueModifier.new(ValueModifier.Operation.MULTIPLY, 0)
	}
