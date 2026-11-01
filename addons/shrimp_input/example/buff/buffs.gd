class_name ExampleShrimpBuffs

static var buffs = [Crit]

class Crit extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "暴击率+3%"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpBaseEntity) -> void:
		entity.critRate += 0.03
