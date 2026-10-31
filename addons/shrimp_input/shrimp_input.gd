@tool
extends EditorPlugin
class_name ShrimpInputPlugin

const TIME_MANAGER = "shrimp_plugin_time_manager"

func _enable_plugin() -> void:
	add_autoload_singleton(TIME_MANAGER, "res://addons/shrimp_input/managers/TimeManager.gd")
func _disable_plugin() -> void:
	remove_autoload_singleton(TIME_MANAGER)
func _enter_tree() -> void:
	pass
func _exit_tree() -> void:
	pass
