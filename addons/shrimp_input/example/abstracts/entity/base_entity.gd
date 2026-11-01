extends RigidBody2D
class_name ExampleShrimpBaseEntity

const DAMAGE = preload("res://addons/shrimp_input/example/bullets/damage/damage.tscn")
const BUFFBALL = preload("res://addons/shrimp_input/example/buff/buff_ball.tscn")

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
var invincible: bool = false
var initialHealth: float

func _ready() -> void:
	initialHealth = health
	if stance == Stance.ENEMY:
		add_to_group("enemy")
func _process(_delta: float) -> void:
	healthBar.max_value = initialHealth
	healthBar.value = health

func die():
	await get_tree().process_frame

func goDie():
	await die()
	var ball = BUFFBALL.instantiate() as ExampleShrimpBuffBall
	ball.position = position
	get_tree().root.add_child.call_deferred(ball)
	queue_free()
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
func hurt(total: float, crited: bool, launcher: ExampleShrimpBaseEntity):
	if !invincible:
		health -= total
		var died = health <= 0
		var dmg = launcher.shoot(DAMAGE, total) as ExampleShrimpDamageBullet
		dmg.position = position
		dmg.crit = crited
		ExampleShrimpCameraManager.addShake(ExampleShrimpCircleSampler.new(5, 0.1))
		if died:
			goDie()
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
