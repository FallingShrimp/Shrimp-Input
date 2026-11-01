class_name ExampleShrimpBuffs

static var buffs = [Crit, Dmg, Reg, Luck, AtkSpd, Heal, HpMax, Bounce, Reflect]

class Dmg extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "伤害+3%"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.damageFactor += 0.03
class Crit extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "暴击+4%"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.critRate += 0.04
class Reg extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "生命恢复+0.6"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.regeneration += 0.6
class HpMax extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "生命上限+20"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.initialHealth += 20
class Luck extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "幸运+1"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.lucky += 1
class Heal extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "获得30点治疗"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.hurt(-30, false, null)
class AtkSpd extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "攻击速度+10%"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.attackSpeed += 0.1
class Bounce extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "反弹+1"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.bounce += 1
class Reflect extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "折射+1"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.reflect += 2
