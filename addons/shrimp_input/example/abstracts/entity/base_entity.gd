extends RigidBody2D
class_name ExampleShrimpBaseEntity

enum Stance {
	PLAYER,
	ENEMY
}

@export var health: float = 100
@export var stance: Stance = Stance.ENEMY

@onready var healthLabel: Label = $%Health
@onready var sounds: Node2D = $%Sounds

func _ready() -> void:
	if stance == Stance.ENEMY:
		add_to_group("enemy")
func _process(_delta: float) -> void:
	healthLabel.text = "%d" % health

func playSound(nameX: String):
	(sounds.get_node(nameX) as AudioStreamPlayer2D).play()
func shoot(bullet: PackedScene, damage: float, rotationX: float = 0):
	var instance = bullet.instantiate() as ExampleShrimpBaseBullet
	instance.launcher = self
	instance.damage = damage
	instance.knockback *= damage / 10
	instance.position = position
	instance.rotation = rotationX
	get_parent().add_child.call_deferred(instance)

static func closet(node: Node2D, filter: Callable = func(_e): return true) -> ExampleShrimpBaseEntity:
	var last = INF
	var result = null
	for i in node.get_tree().get_nodes_in_group("enemy"):
		if i is ExampleShrimpBaseEntity:
			if filter.call(i):
				var d = i.position.distance_to(node.position)
				if d < last:
					result = i
					last = d
	return result
