extends ExampleShrimpBaseEntity

const TEXTURE_DIR = "res://addons/shrimp_input/example/entities/enemy/peoples/releaflyse"
const DASH_BULLET = preload("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")
var speed = 1500

func _ready() -> void:
	for bullet in [shoot(DASH_BULLET, 30)]:
		if bullet is ExampleShrimpBaseBullet:
			bullet.scale *= Vector2(randf_range(0.8, 2), randf_range(0.9, 1.1))
	texture.texture = load("%s/%s" % [TEXTURE_DIR, Array(ResourceLoader.list_directory(TEXTURE_DIR)).pick_random()])
	damageFactor *= randf_range(0.5, 1.3)
	speed *= randf_range(-0.25, 1.75)
	health *= randf_range(0.4, 3)
	setStat(StatsDB.Stats.SCORE_MULT, getStat(StatsDB.Stats.SCORE_MULT) * randf_range(0.5, 2))
	mass *= randf_range(0.75, 1.25)
	super._ready()
func ai(_delta: float) -> void:
	for i in get_tree().get_nodes_in_group("player"):
		if i is ExampleShrimpBaseEntity:
			if i.isLiving:
				apply_central_force((i.position - position).normalized() * speed)
