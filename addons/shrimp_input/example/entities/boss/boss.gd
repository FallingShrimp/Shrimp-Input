extends ExampleShrimpBaseEntity

const TEXTURE_DIR = "res://addons/shrimp_input/example/entities/enemy/peoples/releaflyse"
const DASH_BULLET = preload("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")

func _ready() -> void:
	super._ready()
	setStat(StatsDB.Stats.MOVEMENT_SPEED, 0.75)
	for bullet in [shoot(DASH_BULLET, 30)]:
		if bullet is ExampleShrimpBaseBullet:
			bullet.scale *= Vector2(randf_range(0.8, 2), randf_range(0.9, 1.1))

func ai(_delta: float) -> void:
	for i in get_tree().get_nodes_in_group("player"):
		if i is ExampleShrimpBaseEntity:
			if i.isLiving:
				accelerate(i.position - position)
