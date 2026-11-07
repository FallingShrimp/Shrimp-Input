@abstract
extends Resource
class_name ExampleShrimpBuff

enum Quality {
	NORMAL,
	RARE,
	EPIC,
	LEGENDARY
}

@abstract
func getName() -> StringName
@abstract
func getQuality() -> Quality
@abstract
func execute(entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]
