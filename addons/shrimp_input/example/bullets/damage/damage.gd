extends ExampleShrimpBaseBullet

@onready var damageLabel: Label = $%DMG

func _ready() -> void:
	super._ready()
	damageLabel.text = str(damage)
