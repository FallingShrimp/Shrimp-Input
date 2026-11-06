extends ExampleShrimpBaseEntity

const TEXTURE_DIR = "res://addons/shrimp_input/example/entities/enemy/peoples/releaflyse"
const DASH_BULLET = preload("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")
var speed = 2000

func _ready() -> void:
	shoot(DASH_BULLET, 30)
	var skin = Array(ResourceLoader.list_directory(TEXTURE_DIR)).pick_random()
	texture.texture = load("%s/%s" % [TEXTURE_DIR, skin])
	damageFactor *= randf_range(0.25, 2)
	speed *= randf_range(-0.25, 1.75)
	health *= randf_range(0.4, 3)
	valueMult *= randf_range(0.5, 7)
	mass *= randf_range(0.75, 1.25)
	super._ready()
func ai(_delta: float) -> void:
	for i in get_tree().get_nodes_in_group("player"):
		if i is ExampleShrimpBaseEntity:
			if i.isLiving:
				apply_central_force((i.position - position).normalized() * speed)
