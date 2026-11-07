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
		return {StatsDB.Stats.SCORE_MULT: randf_range(0.1, 0.3)}
class Crit extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "会心一击！"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.CRIT: randf_range(0.01, 0.05)}
class Reg extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "树妖的祝福"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.REGENERATION: randf_range(0.5, 4)}
class HpMax extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "树妖的祝福"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		var value = randf_range(10, 60)
		entity.health += value
		return {StatsDB.Stats.HEALTH_MAX: value}
class Luck extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "狗屎运"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.LUCKY: randf_range(1, 4)}
class Heal extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "自然的回应"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		entity.hurt(-randf_range(15, 50), false)
		return {StatsDB.Stats.REGENERATION: 0.5}
class AtkSpd extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "超高速！！！"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.ATTACK_SPEED: randf_range(0.09, 0.3)}
class Redamage extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "披荆斩棘"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.THORNS_MULT: randf_range(0.1, 0.35)}
class Bounce extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "动量守恒！"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.BOUNCE: randi_range(1, 3)}
class Reflect extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "动量守恒！"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.REFLECT: randi_range(1, 3)}
class Def extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "粉身碎骨"
	func getQuality() -> Quality:
		return Quality.NORMAL
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.DEFENSE: randf_range(5, 20)}
class Momentum extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "无敌冲撞"
	func getQuality() -> Quality:
		return Quality.EPIC
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.MOMENTUM_MULT: randf_range(0.15, 0.4)}
class Dash extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "健步如飞"
	func getQuality() -> Quality:
		return Quality.LEGENDARY
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {
			StatsDB.Stats.DASH: randf_range(0.2, 0.4),
			StatsDB.Stats.MOVEMENT_SPEED: randf_range(0.03, 0.1),
		}
class Track extends ExampleShrimpBuff:
	func getName() -> StringName:
		return "精准制敌"
	func getQuality() -> Quality:
		return Quality.RARE
	func execute(_entity: ExampleShrimpPlayer) -> Dictionary[StatsDB.Stats, float]:
		return {StatsDB.Stats.TRACK: deg_to_rad(randf_range(5, 18))}
