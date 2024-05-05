extends Node3D
var SPEED


func _process(delta) -> void:
	SPEED = GLOBAL.speed
	global_position.z += SPEED * delta


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	global_position.z -= 46
