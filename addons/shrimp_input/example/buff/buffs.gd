class_name ExampleShrimpBuffs

const PRESET_REDMG = [Redamage, Def, HpMax, Reg, Dmg]
const PRESET_TRACK = [Track]
const PRESET_NORMAL = [Crit, Dmg, Reg, Luck, AtkSpd, Heal, HpMax, Bounce, Reflect, Redamage, ScoreMult, Def, Momentum, Dash, Track]

static var use = PRESET_NORMAL
static var buffs = use.map(func(e: GDScript): return e.new())

class Dmg extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "平底锅升温"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.DAMAGE_MULT: randf_range(0.12, 0.30)}
class ScoreMult extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "惹人爱"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.SCORE_MULT: 0.12}
class Crit extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "会心一击！"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.CRIT: 0.03}
class Reg extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "树妖的祝福"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.REGENERATION: 2}
class HpMax extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "树妖的祝福"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		entity.health += 30
		return {StatsDB.Stats.HEALTH_MAX: 30}
class Luck extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "狗屎运"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.LUCKY: 1}
class Heal extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "自然的回应"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		entity.hurt(-30, false)
		return {}
class AtkSpd extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "超高速！！！"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.ATTACK_SPEED: 0.15}
class Redamage extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "披荆斩棘"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.THORNS_MULT: 0.2}
class Bounce extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "动量守恒！"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.BOUNCE: 2}
class Reflect extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "动量守恒！"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.REFLECT: 2}
class Def extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "粉身碎骨"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.DEFENSE: 9}
class Momentum extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "无敌冲撞"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.MOMENTUM_MULT: 0.2}
class Dash extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "健步如飞"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {
			StatsDB.Stats.DASH: 0.15,
			StatsDB.Stats.MOVEMENT_SPEED: 0.05,
		}
class Track extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "精准制敌"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.TRACK: deg_to_rad(10)}
