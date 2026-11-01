extends ExampleShrimpBaseBullet
class_name ExampleShrimpDamageBullet

@onready var damageLabel: Label = $%DMG
var crit: bool = false

func _ready() -> void:
	super._ready()
	if crit:
		damageLabel.label_settings.font_color = Color.GOLD
		damageLabel.text = "-%d!!!" % ceil(damage)
	else:
		damageLabel.label_settings.font_color = Color.RED
		damageLabel.text = "-%d" % ceil(damage)
	position += Vector2.from_angle(randf() * TAU) * randf() * 20
