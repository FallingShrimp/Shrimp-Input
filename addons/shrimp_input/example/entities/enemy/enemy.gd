extends ExampleShrimpBaseEntity

const TEXTURE_DIR = "res://addons/shrimp_input/example/entities/enemy/peoples"
const DASH_BULLET = preload("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")
var speed = 2000

func _ready() -> void:
	shoot(DASH_BULLET, 30)
	var skin = Array(ResourceLoader.list_directory(TEXTURE_DIR)).pick_random()
	texture.texture = load("%s/%s" % [TEXTURE_DIR, skin])
	match skin:
		"ak.png":
			damageFactor *= 0.5
			speed *= -0.25
			health *= 4
			valueMult *= 8
		"dext.png":
			health *= 2
			valueMult *= 0.1
		"jwx.png":
			damageFactor *= 1.3
			valueMult *= 1.2
		"laism.png":
			speed *= 1.15
			valueMult *= 1.05
		"sg.png":
			health *= 0.4
			valueMult *= 0.75
		"yy.png":
			speed = 0
			damageFactor *= 2
			valueMult *= 2
	super._ready()
func ai(_delta: float) -> void:
	for i in get_tree().get_nodes_in_group("player"):
		if i is ExampleShrimpBaseEntity:
			if i.isLiving:
				apply_central_force((i.position - position).normalized() * speed)
