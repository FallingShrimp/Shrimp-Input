class_name ExampleShrimpBuffs

static var buffs = [Crit, Dmg, Reg]

class Dmg extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "伤害+5%"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.damageFactor += 0.05
class Crit extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "暴击+3%"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.critRate += 0.03
class Reg extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "生命恢复+1"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.regeneration += 1
class Luck extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "幸运+5%"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.lucky += 0.05
