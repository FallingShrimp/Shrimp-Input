extends Node
class_name ExampleShrimpLevelManager

const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")

@onready var clock: ShrimpClock = $%Clock
var lastTimeEnterLevel: float = 0
var level: int = 0
var restEnemyToSpawn: int = 0

func _physics_process(_delta: float) -> void:
	if restEnemyToSpawn == 0 && get_tree().get_node_count_in_group("enemy") == 0:
		level += 1
		ExampleShrimpUI.level(level)
		restEnemyToSpawn = floor(randi_range(20, 50) * (1 + level * 0.15))
		for i in restEnemyToSpawn:
			await clock.seconds(1 / (1 + level * 0.15))
			var enemy = ENEMY.instantiate() as ExampleShrimpBaseEntity
			enemy.health = randf_range(25, 40) * level
			enemy.position = Vector2.from_angle(randf() * TAU) * 2000
			enemy.damageFactor += 0.04 * level
			enemy.score = 100 + 25 * level
			get_tree().root.add_child.call_deferred(enemy)
			restEnemyToSpawn -= 1
