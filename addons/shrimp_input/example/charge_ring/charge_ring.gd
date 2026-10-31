@tool
extends Node2D
class_name ExampleShrimpChargeRing

const CUTCOUNT = 32

@export var value: float = 0
@export var maxValue: float = 2
@export var fillingColor: Color
@export var fulledColor: Color

@onready var front: ColorRect = $%Front
var mat: ShaderMaterial

func _ready() -> void:
	mat = front.material
func _process(_delta: float) -> void:
	mat.set_shader_parameter("angle", value / maxValue)
	front.color = fulledColor if value >= maxValue else fillingColor
