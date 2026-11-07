extends Node
class_name ExampleShrimpBaseEffect

var layer: int = 1

func attached(entity: ExampleShrimpBaseEntity):
	return entity
func consumed(entity: ExampleShrimpBaseEntity):
	return entity
func detached(entity: ExampleShrimpBaseEntity):
	return entity
func update(_entity: ExampleShrimpBaseEntity, _delta: float):
	pass
func provideStats() -> Dictionary[StatsDB.Stats, ValueModifier]:
	return {}
