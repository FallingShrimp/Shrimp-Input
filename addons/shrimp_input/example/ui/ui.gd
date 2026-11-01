extends Control
class_name ExampleShrimpUI

static var instance: ExampleShrimpUI

@onready var animator: AnimationPlayer = $%Animator
@onready var levelLabel: Label = $%Level

func _ready() -> void:
	instance = self

static func level(count: int):
	instance.levelLabel.text = str(count)
	instance.animator.play("level")
