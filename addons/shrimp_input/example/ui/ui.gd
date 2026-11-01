extends Control
class_name ExampleShrimpUI

static var instance: ExampleShrimpUI

@onready var levelAnimator: AnimationPlayer = $%LevelAnimator
@onready var levelLabel: Label = $%Level
@onready var buffAnimator: AnimationPlayer = $%BuffAnimator
@onready var buffLabel: Label = $%Buff
@onready var buffNotice: Control = $%BuffNotice
@onready var waveTip: Label = $%Wave
@onready var buffBox: StyleBoxFlat

func _ready() -> void:
	instance = self
	buffBox = buffNotice.get_theme_stylebox("panel")

static func buff(tip: String, color: Color):
	color.a *= 0.6
	instance.buffBox.bg_color = color
	instance.buffLabel.text = tip
	instance.buffAnimator.stop()
	instance.buffAnimator.play("buff")
static func level(count: int):
	instance.waveTip.text = str(count)
	instance.levelLabel.text = str(count)
	instance.levelAnimator.play("level")
