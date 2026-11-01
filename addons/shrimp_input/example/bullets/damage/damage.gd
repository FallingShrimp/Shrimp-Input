extends ExampleShrimpBaseBullet

@onready var damageLabel: Label = $%DMG

func _ready() -> void:
	super._ready()
	damageLabel.text = "-%d" % ceil(damage)
	position += Vector2.from_angle(randf() * TAU) * randf() * 20
