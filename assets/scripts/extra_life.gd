extends Node3D

const SPEED = 2.9

@onready var extra_life : bool = false

func _process(delta) ->void:
	match extra_life:
		false: global_position.z += SPEED * delta

func extra_life_ctrl() -> void:
	extra_life = true
	$Area3D.queue_free()
	$Audio.play()
	
	
func _on_area_3d_body_entered(body):
	if body is Player3D:
		$Audio.play()
		GLOBAL.life +=1
		extra_life_ctrl()
		extra_life = false
