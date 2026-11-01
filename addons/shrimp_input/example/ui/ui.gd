extends Control
class_name ExampleShrimpUI

static var instance: ExampleShrimpUI

@onready var levelAnimator: AnimationPlayer = $%LevelAnimator
@onready var levelLabel: Label = $%Level
@onready var buffAnimator: AnimationPlayer = $%BuffAnimator
@onready var buffLabel: Label = $%Buff

func _ready() -> void:
	instance = self

static func buff(tip: String):
	instance.buffLabel.text = tip
	instance.buffAnimator.play("buff")
static func level(count: int):
	instance.levelLabel.text = str(count)
	instance.levelAnimator.play("level")
