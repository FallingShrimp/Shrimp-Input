extends ExampleShrimpBaseEntity

const DASH_BULLET = preload("res://addons/shrimp_input/example/bullets/dash/dash.tscn")

func _ready() -> void:
	super._ready()
	shoot(DASH_BULLET, 30)
func _physics_process(_delta: float) -> void:
	for i in get_tree().get_nodes_in_group("player"):
		if i is ExampleShrimpBaseEntity:
			apply_central_force((i.position - position).normalized() * 1500)
