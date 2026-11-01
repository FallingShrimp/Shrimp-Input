extends ExampleShrimpBaseEntity

const TEXTURE_DIR = "res://addons/shrimp_input/example/entities/enemy/peoples"
const DASH_BULLET = preload("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")

func _ready() -> void:
	super._ready()
	shoot(DASH_BULLET, 30)
	texture.texture = load("%s/%s" % [TEXTURE_DIR, Array(ResourceLoader.list_directory(TEXTURE_DIR)).pick_random()])
func ai(_delta: float) -> void:
	for i in get_tree().get_nodes_in_group("player"):
		if i is ExampleShrimpBaseEntity:
			if i.isLiving:
				apply_central_force((i.position - position).normalized() * 1500)
