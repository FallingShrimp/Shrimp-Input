extends ExampleShrimpBaseEntity

const TEXTURE_DIR = "res://addons/shrimp_input/example/entities/enemy/peoples"
const DASH_BULLET = preload("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")
var speed = 1500

func _ready() -> void:
	shoot(DASH_BULLET, 30)
	var skin = Array(ResourceLoader.list_directory(TEXTURE_DIR)).pick_random()
	texture.texture = load("%s/%s" % [TEXTURE_DIR, skin])
	match skin:
		"ak.png":
			damageFactor *= 0.5
			speed *= -0.25
			health *= 4
		"dext.png":
			health *= 2
		"jwx.png":
			damageFactor += 0.2
		"laism.png":
			speed *= 1.15
		"sg.png":
			health *= 0.4
		"yy.png":
			damageFactor *= 1.08
			redamage += 1
	super._ready()
func ai(_delta: float) -> void:
	for i in get_tree().get_nodes_in_group("player"):
		if i is ExampleShrimpBaseEntity:
			if i.isLiving:
				apply_central_force((i.position - position).normalized() * speed)
