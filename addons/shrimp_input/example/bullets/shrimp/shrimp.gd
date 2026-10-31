extends ExampleShrimpBaseBullet

@onready var rotator: AnimationPlayer = $%Rotate
@onready var anchor: Node2D = $%Anchor
@onready var dmg: Label = $%Damage

func _ready() -> void:
	super._ready()
	dmg.text = str(damage)
func _process(_delta: float) -> void:
	anchor.global_rotation = 0

func ai(delta: float) -> void:
	position += Vector2.from_angle(rotation) * speed * delta
func onDie():
	var effect = BLOOD.instantiate() as GPUParticles2D
	effect.emitting = true
	add_child(effect)
	effect.global_rotation = 0
	rotator.stop(true)
