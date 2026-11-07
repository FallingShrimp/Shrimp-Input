extends RigidBody2D
class_name ExampleShrimpBuffBall

const BUFFBALL = preload("res://addons/shrimp_input/example/buff/buff_ball.tscn")

@export var qualityLuckyOffset: Dictionary[ExampleShrimpBuff.Quality, float] = {}
@export var qualityWeight: Dictionary[ExampleShrimpBuff.Quality, float] = {}
@export var qualityColor: Dictionary[ExampleShrimpBuff.Quality, Color] = {}
@export var buff: ExampleShrimpBuff

@onready var texture: Sprite2D = $%Texture
var mat: ShaderMaterial

func _ready() -> void:
	if !is_instance_valid(buff):
		buff = gacha(get_tree().get_nodes_in_group("player")[0])
	var color = qualityColor[buff.getQuality()]
	mat = texture.material
	mat.set_shader_parameter("line_color", color)
	apply_central_impulse(Vector2.from_angle(randf() * TAU) * randf() * 2000)
	apply_torque_impulse(randf_range(-1, 1) * 10000)
	scale *= randf_range(0.5, 2)
	body_entered.connect(
		func(e):
			if e is ExampleShrimpPlayer:
				e.playSound("Collect")
				var tip = []
				var stats = buff.execute(e)
				for key in stats:
					e.setStat(key, e.getStat(key) + stats[key])
					tip.append("%s+%s" % [StatsDB.stats[key].name, StatsDB.format(stats[key], StatsDB.stats[key].dataType)])
				ExampleShrimpUI.buff(buff.getName(), "\n".join(tip), color)
				queue_free()
	)

func gacha(player: ExampleShrimpPlayer) -> ExampleShrimpBuff:
	var pool = (
		ExampleShrimpBuffs
			.buffs
			.reduce(
				func(cur: Dictionary, next: ExampleShrimpBuff):
					var q = next.getQuality()
					return cur.merged({next: max(1, qualityWeight[q] + qualityLuckyOffset[q] * player.getStat(StatsDB.Stats.LUCKY))}),
				{}
			)
	)
	var totalw = 0.0
	for w in pool.values():
		totalw += w
	var taregt = randf() * totalw
	var pointer = 0.0
	for item in pool:
		pointer += pool[item]
		if taregt < pointer:
			return item
	return pool.keys().back()

static func reward(where: Node, positionX: Vector2):
	var ball = BUFFBALL.instantiate() as ExampleShrimpBuffBall
	ball.position = positionX
	where.add_child.call_deferred(ball)
