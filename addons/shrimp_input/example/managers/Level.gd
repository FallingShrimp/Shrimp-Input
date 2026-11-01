extends Node
class_name ExampleShrimpLevelManager

const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")

var level: int = 0

func _physics_process(_delta: float) -> void:
	if get_tree().get_node_count_in_group("enemy") == 0:
		level += 1
		ExampleShrimpUI.level(level)
		for i in randi_range(3, 5) * level:
			var enemy = ENEMY.instantiate() as ExampleShrimpBaseEntity
			enemy.health = randf_range(50, 200) * level
			enemy.position = Vector2.from_angle(randf() * TAU) * randf_range(800, 1500)
			get_tree().root.add_child.call_deferred(enemy)
