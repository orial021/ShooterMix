extends Area3D

const SPEED = 18

func _process(delta) -> void:
	global_position.z -= SPEED * delta


func _on_area_entered(area):
	if area.is_in_group("Enemy3D"):
		queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
