class_name ExampleShrimpBuffs

static var buffs = (
	[Crit, Dmg, Dmg2, Dmg3, Reg, Luck, AtkSpd, Heal, HpMax, Bounce, Reflect, Redamage, ScoreMult, MoreScore]
		.map(func(e: GDScript): return e.new())
)

class Dmg extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "伤害+15%"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.damageFactor += 0.15
class Dmg2 extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "伤害+20%"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.damageFactor += 0.2
class Dmg3 extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "伤害+25%"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.damageFactor += 0.25
class ScoreMult extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "分数倍率+50%"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.scoreMult += 0.5
class Crit extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "暴击+5%"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.critRate += 0.05
class Reg extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "生命恢复+2"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.regeneration += 2
class HpMax extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "生命上限+30"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.initialHealth += 30
		entity.health += 30
class Luck extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "幸运+2"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.lucky += 2
class Heal extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "获得30点治疗"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.hurt(-30, false)
class AtkSpd extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "攻击速度+25%"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.attackSpeed += 0.25
class Redamage extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "荆棘反伤+15"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.redamage += 15
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
class MoreScore extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "获得大量分数"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(entity: ExampleShrimpPlayer) -> void:
		ExampleShrimpUI.addScore(ExampleShrimpUI.instance.rewardMax * 10, entity.get_tree().root)
