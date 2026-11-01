extends RigidBody2D
class_name ExampleShrimpBaseEntity

const DAMAGE = preload("res://addons/shrimp_input/example/bullets/damage/damage.tscn")
const BUFFBALL = preload("res://addons/shrimp_input/example/buff/buff_ball.tscn")
var Actions = ExampleShrimpActions

enum Stance {
	PLAYER,
	ENEMY
}

@export var health: float = 100
@export var stance: Stance = Stance.ENEMY
@export var damageFactor: float = 1
@export var critRate: float = 0

@onready var sounds: Node2D = $%Sounds
@onready var healthBar: ProgressBar = $%Health
@onready var animator: AnimationPlayer = $%Animator
@onready var hitbox: CollisionShape2D = $%Hitbox
var invincible: bool = false
var initialHealth: float
var bounce: int = 0
var reflect: int = 0
var isLiving: bool:
	get:
		return health > 0

func _ready() -> void:
	initialHealth = health
	if stance == Stance.ENEMY:
		add_to_group("enemy")
func _process(_delta: float) -> void:
	healthBar.max_value = initialHealth
	healthBar.value = health
func _physics_process(delta: float) -> void:
	if isLiving:
		ai(delta)

func ai(_delta: float):
	pass
func die():
	await get_tree().process_frame

func goDie(by: ExampleShrimpBaseBullet):
	await die()
	match stance:
		Stance.ENEMY:
			if by.launcher is ExampleShrimpPlayer:
				var launch = by.launcher as ExampleShrimpPlayer
				var out = floor(launch.lucky)
				var count = out + int(randf() < launch.lucky - out)
				for i in count:
					var ball = BUFFBALL.instantiate() as ExampleShrimpBuffBall
					ball.position = position
					get_tree().root.add_child.call_deferred(ball)
			queue_free()
		Stance.PLAYER:
			hitbox.disabled = true
			Actions.ROOT_ACTION.ban()
func playSound(nameX: String):
	(sounds.get_node(nameX) as AudioStreamPlayer2D).play()
func shoot(bullet: PackedScene, damage: float, rotationX: float = 0) -> ExampleShrimpBaseBullet:
	var instance = bullet.instantiate() as ExampleShrimpBaseBullet
	instance.launcher = self
	instance.damage = damage
	instance.knockback *= damage / 10
	instance.position = position
	instance.rotation = rotationX
	get_tree().root.add_child.call_deferred(instance)
	apply_central_impulse(-Vector2.from_angle(rotationX) * instance.launchRecoil)
	return instance
func hurt(total: float, crited: bool, by: ExampleShrimpBaseBullet):
	if !invincible:
		health -= total
		var died = health <= 0
		var dmg: ExampleShrimpDamageBullet = shoot(DAMAGE, total)
		dmg.position = position
		dmg.crit = crited
		ExampleShrimpCameraManager.addShake(ExampleShrimpCircleSampler.new(5, 0.1))
		if died:
			goDie(by)
		else:
			playSound("Hurt")
			animator.play("hurt")

static func closet(node: Node2D, filter: Callable = func(_e): return true) -> ExampleShrimpBaseEntity:
	var last = INF
	var result = null
	for i in node.get_tree().get_nodes_in_group("enemy"):
		if i is ExampleShrimpBaseEntity:
			if filter.call(i):
				var d = i.position.distance_to(node.position)
				if d < last:
					result = i
					last = d
	return result
