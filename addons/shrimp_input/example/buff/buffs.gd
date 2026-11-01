class_name ExampleShrimpBuffs

static var buffs = [Crit, Dmg, Reg, Luck, AtkSpd]

class Dmg extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "伤害+3%"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.damageFactor += 0.03
class Crit extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "暴击+4%"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.critRate += 0.04
class Reg extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "生命恢复+0.5"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.regeneration += 0.5
class Luck extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "幸运+10%"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.lucky += 0.1
class Heal extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "治疗10血量"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.lucky += 0.1
class AtkSpd extends ExampleShrimpBuffBall.Buff:
	func getName() -> StringName:
		return "攻击速度+10%"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.attackSpeed += 0.1
