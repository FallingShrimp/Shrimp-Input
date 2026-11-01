extends RigidBody2D
class_name ExampleShrimpBuffBall

@abstract
class Buff extends RefCounted:
	@abstract
	func getName() -> StringName
	@abstract
	func getQuality() -> Quality
	@abstract
	func execute(entity: ExampleShrimpPlayer) -> void

enum Quality {
	NORMAL,
	RARE,
	EPIC,
	LEGENDARY
}

@export var qualityWeight: Dictionary[Quality, float] = {}
@export var qualityColor: Dictionary[Quality, Color] = {}
var buff: Buff

@onready var texture: Sprite2D = $%Texture
var mat: ShaderMaterial

func _ready() -> void:
	buff = gacha()
	var color = qualityColor[buff.getQuality()]
	mat = texture.material
	mat.set_shader_parameter("line_color", color)
	apply_central_impulse(Vector2.from_angle(randf() * TAU) * randf() * 2000)
	apply_torque_impulse(randf_range(-1, 1) * 10000)
	scale *= randf_range(0.5, 2)
	body_entered.connect(
		func(e):
			if e is ExampleShrimpBaseEntity:
				if e.stance == ExampleShrimpBaseEntity.Stance.PLAYER:
					e.playSound("Collect")
					buff.execute(e)
					ExampleShrimpUI.buff(buff.getName(), color)
					queue_free()
	)

func gacha() -> Buff:
	var pool = (
		ExampleShrimpBuffs.buffs
			.map(func(e: GDScript): return e.new())
			.reduce(
				func(cur: Dictionary, next: Buff):
					return cur.merged({next: qualityWeight[next.getQuality()]}),
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
