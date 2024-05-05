extends CharacterBody2D
class_name Player2D 

var touch_position = Vector2()
@export var shot : PackedScene
@onready var screensize = get_viewport_rect().size
const SPEED = 300 
var direction = Vector2()



func _process(_delta):
	anim_ctrl()
	motion_ctrl()
	touch_ctrl()
	
func _input(event):
	if event.is_action_pressed("ui_accept") and GLOBAL.bullets > 0 or event is InputEventScreenTouch and touch_position == $Spaceship.global_position and GLOBAL.bullets > 0:
		shoot_ctrl()
	if event is InputEventScreenTouch and event.pressed:
		touch_position = event.position
		touch_ctrl()
	elif event is InputEventScreenDrag:
		touch_position = event.position
		touch_ctrl()
	elif event is InputEventScreenTouch and not event.pressed:
		touch_position = $Spaceship.global_position
	else:
		motion_ctrl()
		
func anim_ctrl() -> void:
	if GLOBAL.get_axis().y > 0 or get_axis(touch_position).y < 0:
		$Spaceship.animation = "Up"
	elif GLOBAL.get_axis().y < 0 or get_axis(touch_position).y > 0:
		$Spaceship.animation = "Down"
	else:
		$Spaceship.animation = "Idle"

func motion_ctrl() -> void:
	velocity.x = GLOBAL.get_axis().x * SPEED
	velocity.y = GLOBAL.get_axis().y * -SPEED
	move_and_slide()
	
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
func touch_ctrl() -> void:
	velocity.x = get_axis(touch_position).x * SPEED
	velocity.y = get_axis(touch_position).y * SPEED
	move_and_slide()
	
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
func shoot_ctrl() -> void:
	$Flash.play("Flash")
	$Settings/AudioShot.play()
	GLOBAL.bullets -= 1
	
	var shot_instance = shot.instantiate()
	shot_instance.global_position = $Settings/ShotSpawn.global_position
	get_tree().call_group("Level", "add_child", shot_instance)

func get_axis(touch: Vector2) -> Vector2:
	var player_position = $Spaceship.global_position
	if touch == Vector2.ZERO:
		return Vector2.ZERO
	else:
		direction.x = touch.x - player_position.x
		direction.y = touch.y - player_position.y
		if direction.length() > 10:
			return direction.normalized()
		else:
			return Vector2()

