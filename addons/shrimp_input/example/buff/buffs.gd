class_name ExampleShrimpBuffs

const PRESET_REDMG = [Redamage, Def, HpMax, Reg, Dmg]
const PRESET_NORMAL = [Crit, Dmg, Reg, Luck, AtkSpd, Heal, HpMax, Bounce, Reflect, Redamage, ScoreMult, Def, Momentum]

static var use = PRESET_NORMAL
static var buffs = use.map(func(e: GDScript): return e.new())

class Dmg extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "伤害增加"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.damageFactor += randf_range(0.05, 0.25)
class ScoreMult extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "分数倍率+20%"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.scoreMult += 0.25
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
		return "荆棘+25%"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.thornsMult += 0.25
class Bounce extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "反弹+2"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.bounce += 2
class Reflect extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "折射+2"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.reflect += 2
class Def extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "护甲+9"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.defense += 9
class Momentum extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "动量+20%"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> void:
		entity.momentumMult += 0.2
