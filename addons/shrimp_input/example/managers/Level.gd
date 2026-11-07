extends Node
class_name ExampleShrimpLevelManager

const BOSSWAVE = 5
const ENEMY = preload("res://addons/shrimp_input/example/entities/enemy/enemy.tscn")
const BOSS = preload("res://addons/shrimp_input/example/entities/boss/boss.tscn")

@onready var clock: ShrimpClock = $%Clock
var lastTimeEnterLevel: float = 0
var level: int = 0
var totalEnemy: int = 0
var restEnemyToSpawn: int = 0

func _physics_process(_delta: float) -> void:
	var enemies = (
		get_tree()
			.get_nodes_in_group("enemy")
			.filter(func(e): return e is ExampleShrimpBaseEntity)
			.map(func(e: ExampleShrimpBaseEntity): return e.healthPercent)
	)
	var enemyCount = len(enemies)
	ExampleShrimpUI.instance.progress = 1.0 * (restEnemyToSpawn + enemies.reduce(func(a, b): return a + b, 0)) / totalEnemy
	if restEnemyToSpawn <= 0 && enemyCount == 0:
		level += 1
		ExampleShrimpUI.level(level)
		if level % BOSSWAVE == 0:
			totalEnemy = 1
			restEnemyToSpawn = 1
			spawn(BOSS, true)
			await clock.seconds(1)
			while get_tree().get_node_count_in_group("boss"):
				await clock.seconds(2.5)
				totalEnemy += 1
				restEnemyToSpawn += 1
				spawn(ENEMY, false)
		else:
			totalEnemy = floor(randi_range(5, 15) * (1 + level * 0.1))
			restEnemyToSpawn = totalEnemy
			for i in restEnemyToSpawn:
				await clock.seconds(1 / (1 + level * 0.15))
				spawn(ENEMY, false)

func spawn(scn: PackedScene, isBoss: bool):
	var enemy = scn.instantiate() as ExampleShrimpBaseEntity
	enemy.position = Vector2.from_angle(randf() * TAU) * 2000
	if isBoss:
		enemy.health = randf_range(300, 500) * level
		enemy.damageFactor += 0.03 * level
		enemy.score = 1000 + 500 * level
	else:
		enemy.health = randf_range(25, 40) * level
		enemy.damageFactor += 0.02 * level
		enemy.score = 100 + 25 * level
	get_tree().root.add_child.call_deferred(enemy)
	restEnemyToSpawn -= 1
