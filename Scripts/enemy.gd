extends Node2D

var SPEED : int = 210

@onready var explosion : bool = false

func _ready() -> void:
	SPEED = (GLOBAL.speed + GLOBAL.level) * 70
	
func _process(delta) -> void:
	match explosion:
		false: global_position.x -= SPEED * delta

func explosion_ctrl() -> void:
	explosion = true
	$Area2D.queue_free()
	$Explosion.play("Explosion")
	$Explosion/Audio.play()

func _on_area_2d_area_entered(area) -> void:
	if area.is_in_group("Shot"):
		explosion_ctrl()
		GLOBAL.score += 100
		GLOBAL.can_change = true


func _on_area_2d_body_entered(body) -> void:
	if body is Player2D:
		explosion_ctrl()
		GLOBAL.life -= 1
		if GLOBAL.life <= 0:
			body.queue_free()
		else:
			return
		
		


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_audio_finished() -> void:
	if GLOBAL.life <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		
