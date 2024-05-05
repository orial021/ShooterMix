extends CharacterBody3D
class_name Player3D

@export var shot : PackedScene
var can_shot : bool = false


const SPEED = 2.5

func _process(_delta) -> void:
	motion_ctrl()
	anim_ctrl()
	
func _input(event):
	if GLOBAL.is_shot and can_shot or can_shot and event.is_action_pressed("ui_accept"):
		shot_ctrl()
		
func tween_ctrl(node, propierty : String, final_val, duration : float) -> void:
	var tween : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween. EASE_OUT)
	tween.tween_property(node, propierty, final_val, duration)
	
func anim_ctrl() -> void:
	if GLOBAL.get_axis().x > 0:
		tween_ctrl($Spaceship, "rotation", Vector3($Spaceship.rotation.x, $Spaceship.rotation.y, 0.6), 0.6)
		$Spaceship/Fire_1.play("turn")
		tween_ctrl($Spaceship/Fire_2, "scale", Vector3(5, 15, 2), 0.5)
	elif GLOBAL.get_axis().x < 0:
		tween_ctrl($Spaceship, "rotation", Vector3($Spaceship.rotation.x, $Spaceship.rotation.y, -0.6), 0.6)
		$Spaceship/Fire_2.play("turn")
		tween_ctrl($Spaceship/Fire_1, "scale", Vector3(5, 15, 2), 0.5)
	elif GLOBAL.get_axis().y > 0:
		tween_ctrl($Spaceship, "rotation", Vector3(-0.5, $Spaceship.rotation.y, $Spaceship.rotation.z), 0.6)
		$Spaceship/Fire_3.play("up")
		$Spaceship/Fire_4.play("up")
	elif GLOBAL.get_axis().y < 0:
		tween_ctrl($Spaceship, "rotation", Vector3(0.5, $Spaceship.rotation.y, $Spaceship.rotation.z), 0.6)
		$Spaceship/Fire_3.play("up")
		$Spaceship/Fire_4.play("up")
	else:
		tween_ctrl($Spaceship, "rotation", Vector3.ZERO, 0.5)
		$Spaceship/Fire_1.play("fire")
		$Spaceship/Fire_2.play("fire")
		$Spaceship/Fire_3.play("fire")
		$Spaceship/Fire_4.play("fire")
		tween_ctrl($Spaceship/Fire_1, "scale", Vector3(5, 5, 2), 0.5)
		tween_ctrl($Spaceship/Fire_2, "scale", Vector3(5, 5, 2), 0.5)
		
func motion_ctrl() -> void:
	velocity.x = GLOBAL.get_axis().x * SPEED
	velocity.z = GLOBAL.get_axis().y * -SPEED
	move_and_slide()
	
func shot_ctrl() -> void:
	$Settings/shot.play()
	var shot_instance : Area3D = shot.instantiate()
	get_tree().call_group("Level3D", "add_child", shot_instance)
	shot_instance.set_global_position($Settings/ShootSpawn.get_global_position())
	
func _on_crosshair_area_entered(area) -> void:
	if area.is_in_group("Enemy3D"):
		can_shot = true
		tween_ctrl($Settings/Crosshair/Sprite3D, "scale", Vector3(0.6, 0.6, 0.6), 0.2)
		tween_ctrl($Settings/Crosshair/Sprite3D, "modulate", Color(255, 0, 0, 1.0), 0.1)
		tween_ctrl($Settings/Crosshair/Sprite3D, "rotation", Vector3($Settings/Crosshair/Sprite3D.rotation.x, 0.5, $Settings/Crosshair/Sprite3D.rotation.z), 0.3)
		$Settings/Crosshair/Sound.play()

func _on_crosshair_area_exited(area) -> void:
	if area.is_in_group("Enemy3D"):
		can_shot = false
		tween_ctrl($Settings/Crosshair/Sprite3D, "scale", Vector3(0.3, 0.3, 0.3), 0.2)
		tween_ctrl($Settings/Crosshair/Sprite3D, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.1)
