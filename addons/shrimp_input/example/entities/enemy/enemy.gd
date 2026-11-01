extends ExampleShrimpBaseEntity

const DASH_BULLET = preload("res://addons/shrimp_input/example/bullets/dash/dash.tscn")
const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")

func _ready() -> void:
	super._ready()
	shoot(DASH_BULLET, 30)
func _physics_process(_delta: float) -> void:
	for i in get_tree().get_nodes_in_group("player"):
		if i is ExampleShrimpBaseEntity:
			apply_central_force((i.position - position).normalized() * 1500)

func die():
	if randf() < 0.5:
		var enemy = ENEMY.instantiate() as ExampleShrimpBaseEntity
		enemy.health = initialHealth + 10
		enemy.position = Vector2.from_angle(randf() * TAU) * randf_range(800, 1500)
		get_tree().root.add_child.call_deferred(enemy)
