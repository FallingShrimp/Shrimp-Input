extends RigidBody2D

const BULLET = preload("res://addons/shrimp_input/example/BULLET/BULLET.tscn")
const MAX_CHARGE = 2.0

@onready var input: ShrimpInput = $%ShrimpInput
@onready var charge: ExampleShrimpChargeRing = $%ChargeRing
var actions = preload("res://addons/shrimp_input/example/actions.gd").new()

func _ready() -> void:
	inputLoop()
func _physics_process(_delta: float) -> void:
	var dir = Input.get_vector(
		actions.MOVE_LEFT.inputEvent,
		actions.MOVE_RIGHT.inputEvent,
		actions.MOVE_UP.inputEvent,
		actions.MOVE_DOWN.inputEvent
	)
	apply_central_force(dir * 3000)

func inputLoop():
	while true:
		# 等待一帧，防止输入循环卡住主循环
		await input.clock.frame()
		# 等待直到按下攻击
		await input.press(actions.ATTACK)
		# 普通攻击，10伤害
		shoot(10)
		# 若按住攻击不松手至少0.2秒
		if await input.hold(actions.ATTACK, 0.2):
			charge.maxValue = MAX_CHARGE
			var hold = 0
			# 按住攻击键持续蓄力，最多MAX_CHARGE秒
			while input.charge(actions.ATTACK, MAX_CHARGE):
				# 每帧累积一次蓄力时长
				hold += await input.clock.frame()
				# 更新视觉效果
				charge.value = hold
			# 蓄力完成，重击，伤害为10+蓄力进度*50
			shoot(10 + hold / MAX_CHARGE * 50)
			# 更新视觉效果
			charge.value = 0
		# 攻击间隔0.3秒
		await input.clock.seconds(0.3)
		# 等待直到松开攻击，防止玩家一直按住攻击触发重击
		await input.release(actions.ATTACK)
func shoot(damage: float):
	var b = BULLET.instantiate() as ExampleShrimpBullet
	b.damage = damage
	b.position = position
	b.rotation = position.angle_to_point(get_global_mouse_position())
	get_parent().add_child.call_deferred(b)
