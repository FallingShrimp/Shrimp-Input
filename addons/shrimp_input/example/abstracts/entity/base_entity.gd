extends RigidBody2D
class_name ExampleShrimpBaseEntity

const MULTISHOT_MAXANGLE = 60
const MULTISHOT_PERANGLE = 10
const PLAYER_SPEED = 3000
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
@export var statsOverride: Dictionary[StatsDB.Stats, float] = {}

@onready var texture: Sprite2D = $%Texture
@onready var sounds: Node2D = $%Sounds
@onready var healthBar: ProgressBar = $%Health
@onready var animator: AnimationPlayer = $%Animator
@onready var hitbox: CollisionShape2D = $%Hitbox
var effects: Array[ExampleShrimpBaseEffect] = []
var dieing: bool = false
var invincible: bool = false
var internalStats: Dictionary[StatsDB.Stats, float]
var stats: Dictionary:
	get:
		var result = internalStats.duplicate()
		for effect in effects:
			var modifiers: Dictionary[StatsDB.Stats, ValueModifier] = effect.provideStats()
			for key in modifiers:
				result[key] = modifiers[key].modify(result[key])
		return result
var score: float = 0
var isLiving: bool:
	get:
		return health > 0
var healthPercent: float:
	get:
		return health / getStat(StatsDB.Stats.HEALTH_MAX)

func _ready() -> void:
	internalStats = StatsDB.create().merged(statsOverride, true)
	setStat(StatsDB.Stats.HEALTH_MAX, health)
	if stance == Stance.ENEMY:
		add_to_group("enemy")
func _physics_process(delta: float) -> void:
	healthBar.max_value = lerpf(healthBar.max_value, getStat(StatsDB.Stats.HEALTH_MAX), delta * 20)
	healthBar.value = lerpf(healthBar.value, health, delta * 20)
	if isLiving:
		ai(delta)
		if health < getStat(StatsDB.Stats.HEALTH_MAX):
			health += getStat(StatsDB.Stats.REGENERATION) * delta
	for effect in effects:
		effect.update(self, delta)

func ai(_delta: float):
	pass
func die():
	await get_tree().process_frame

func accelerate(direction: Vector2):
	apply_central_force(direction.normalized() * PLAYER_SPEED * getStat(StatsDB.Stats.MOVEMENT_SPEED))
func attachEffect(eff: GDScript, layer: int = 1):
	if layer <= 0: return
	var pos = effects.map(func(e: Object): return e.get_script()).find(eff)
	if pos >= 0:
		var e: ExampleShrimpBaseEffect = effects[pos]
		e.layer += 1
		e.layered(self)
	else:
		var e = eff.new()
		add_child(e)
		effects.append(e)
		e.attached(self)
	attachEffect(eff, layer - 1)
func consumeEffect(eff: GDScript):
	var pos = effects.map(func(e: Object): return e.get_script()).find(eff)
	if pos >= 0:
		var e: ExampleShrimpBaseEffect = effects[pos]
		e.layer -= 1
		e.consumed(self)
		if e.layer <= 0:
			effects.erase(e)
			e.detached(self)
			e.queue_free()
func getStat(key: StatsDB.Stats) -> float:
	return stats.get(key, 0)
func setStat(key: StatsDB.Stats, value: float):
	internalStats.set(key, value)
func getMomentum() -> Vector2:
	return linear_velocity * mass * getStat(StatsDB.Stats.MOMENTUM_MULT)
func goDie():
	if dieing: return
	dieing = true
	await die()
	match stance:
		Stance.ENEMY:
			ExampleShrimpUI.addScore(score * getStat(StatsDB.Stats.SCORE_MULT), get_tree().root)
			queue_free()
		Stance.PLAYER:
			hitbox.disabled = true
			Actions.ROOT.ban()
func playSound(nameX: String):
	(sounds.get_node(nameX) as AudioStreamPlayer2D).play()
func shoot(bullet: PackedScene, damage: float, rotationX: float = 0) -> Array[ExampleShrimpBaseBullet]:
	var count = 1 + getStat(StatsDB.Stats.MULTISHOT)
	var totalAngle = deg_to_rad(min(MULTISHOT_MAXANGLE, (count - 1) * MULTISHOT_PERANGLE))
	var split = totalAngle / (count - 1)
	if count == 1:
		split = 0
	var recoil: float = 0
	var result: Array[ExampleShrimpBaseBullet] = []
	for i in count:
		var instance = bullet.instantiate() as ExampleShrimpBaseBullet
		instance.launcher = self
		instance.damage = damage
		instance.knockback *= damage / 10
		instance.position = position
		instance.rotation = rotationX - totalAngle / 2 + i * split
		recoil = instance.launchRecoil
		result.append(instance)
		(
			func():
				for j in i:
					await get_tree().process_frame
				get_tree().root.add_child.call_deferred(instance)
		).call()
	apply_central_impulse(-Vector2.from_angle(rotationX) * recoil)
	return result
func hurt(total: float, crited: bool):
	if invincible || total == 0:
		return
	health -= total
	var died = health <= 0
	for dmg in shoot(DAMAGE, total):
		if dmg is ExampleShrimpDamageBullet:
			dmg.position = position
			dmg.crit = crited
			dmg.fromPlayer = stance == Stance.ENEMY
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
