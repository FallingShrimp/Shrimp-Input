class_name StatsDB

class Stat extends RefCounted:
	var dataType: DataType
	var initial: float
	var name: StringName

	func _init(dataTypeX: DataType, initialX: float, nameX: StringName) -> void:
		dataType = dataTypeX
		initial = initialX
		name = nameX

enum DataType {
	INT,
	FLOAT,
	ANGLE,
	PERCENT,
	FREQUENCY
}
enum Stats {
	MOVEMENT_SPEED,
	HEALTH_MAX,
	DAMAGE_MULT,
	ATTACK_SPEED,
	BOUNCE,
	REFLECT,
	TRACK,
	THORNS_MULT,
	MOMENTUM_MULT,
	DEFENSE,
	REGENERATION,
	LUCKY,
	SCORE_MULT,
	DASH,
	CRIT,
	VULNERABILITY
}

static var stats: Dictionary[Stats, Stat] = {
	Stats.MOVEMENT_SPEED: Stat.new(DataType.PERCENT, 1, "移动速度"),
	Stats.HEALTH_MAX: Stat.new(DataType.FLOAT, 100, "生命上限"),
	Stats.DAMAGE_MULT: Stat.new(DataType.PERCENT, 1, "伤害"),
	Stats.ATTACK_SPEED: Stat.new(DataType.PERCENT, 1, "攻击速度"),
	Stats.BOUNCE: Stat.new(DataType.INT, 0, "反弹"),
	Stats.REFLECT: Stat.new(DataType.INT, 0, "弹射"),
	Stats.TRACK: Stat.new(DataType.ANGLE, 0, "追踪"),
	Stats.THORNS_MULT: Stat.new(DataType.PERCENT, 0, "荆棘"),
	Stats.MOMENTUM_MULT: Stat.new(DataType.PERCENT, 1, "动量"),
	Stats.DEFENSE: Stat.new(DataType.FLOAT, 0, "装甲"),
	Stats.REGENERATION: Stat.new(DataType.FLOAT, 0, "再生"),
	Stats.LUCKY: Stat.new(DataType.FLOAT, 0, "幸运"),
	Stats.SCORE_MULT: Stat.new(DataType.PERCENT, 1, "得分倍率"),
	Stats.DASH: Stat.new(DataType.PERCENT, 1, "闪避"),
	Stats.CRIT: Stat.new(DataType.PERCENT, 0, "暴击"),
	Stats.VULNERABILITY: Stat.new(DataType.PERCENT, 0, "易伤")
}

static func create() -> Dictionary[Stats, float]:
	var result: Dictionary[Stats, float] = {}
	for key in stats:
		result[key] = stats[key].initial
	return result
static func format(data: float, type: DataType):
	match type:
		DataType.INT:
			return "%d" % data
		DataType.FLOAT:
			return "%.1f" % data
		DataType.PERCENT:
			return "%.1f%%" % (data * 100)
		DataType.ANGLE:
			return "%.1f°" % rad_to_deg(data)
		DataType.FREQUENCY:
			return "%.1fHz" % data
