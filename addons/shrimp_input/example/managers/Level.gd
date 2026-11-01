extends Node
class_name ExampleShrimpLevelManager

const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")

@onready var countdown: Timer = $%LevelCountdown
var lastTimeEnterLevel: float = 0
var level: int = 0

func _physics_process(_delta: float) -> void:
	if countdown.is_stopped():
		if get_tree().get_node_count_in_group("enemy") == 0:
			level += 1
			ExampleShrimpUI.level(level)
			countdown.start()
			await countdown.timeout
			for p in get_tree().get_nodes_in_group("player"):
				if p is ExampleShrimpBaseEntity:
					for i in randi_range(3, 5) * level:
						var enemy = ENEMY.instantiate() as ExampleShrimpBaseEntity
						enemy.health = randf_range(50, 200) * level
						enemy.position = p.position + Vector2.from_angle(randf() * TAU) * randf_range(1000, 2000)
						get_tree().root.add_child.call_deferred(enemy)
