extends Node3D
class_name Enemy3D

var SPEED

@onready var gui : CanvasLayer = get_parent().get_node("GUI")
@onready var explosion : bool = false
@onready var game_over : bool = false


func _process(delta) ->void:
	SPEED = GLOBAL.speed
	match explosion:
		false: global_position.z += SPEED * delta
	
		
func explosion_ctrl(explosion_scale : Vector3) -> void:
	explosion = true
	$Area3D.queue_free()
	$Explosion.scale = explosion_scale
	$Explosion.play("Explosion")
	$Explosion/Audio.play()

func _on_explosion_animation_finished():
	match game_over:
		false:
			queue_free()
		true:
			get_tree().change_scene_to_file("res://Scenes/game_over.tscn")


func _on_area_3d_area_entered(area) -> void:
	if area.is_in_group("Shot3D"):
		explosion_ctrl(Vector3(1, 1, 1))
		GLOBAL.points += 10
		if GLOBAL.points % 50 ==0:
			GLOBAL.speed += 1
			GLOBAL.level += 1


func _on_area_3d_body_entered(body):
	if body is Player3D:
		explosion_ctrl(Vector3(1.4, 1.4, 1.4))
		GLOBAL.life -= 1
		if GLOBAL.life < 1:
			game_over = true
			explosion_ctrl(Vector3(1.4, 1.4, 1.4))
			
			body.queue_free()


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
