extends Node2D

var SPEED = 180

@onready var extra_bullet : bool = false

func _process(delta) -> void:
	match extra_bullet:
		false: global_position.x -= SPEED * delta

func explosion_ctrl() -> void:
	extra_bullet = true
	$Bullet.queue_free()

func _on_bullet_body_entered(body):
	if body is Player2D:
		explosion_ctrl()
		GLOBAL.bullets += 5


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
