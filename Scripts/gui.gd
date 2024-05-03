extends CanvasLayer


func _ready() -> void:
	$Scoreboard/ColorRect.visible = false
	
func _process(_delta):
	%Credits.text = "SPACESHIPS: " + str(GLOBAL.life)
	%Score.text = "SCORE: " + str(GLOBAL.score)
	$Scoreboard/MarginContainer/Level.text = "level " + str(GLOBAL.level)
	
	if GLOBAL.score % 1000 == 0 and GLOBAL.can_change:
		$Scoreboard/ColorRect.visible = true
		$Scoreboard/ColorRect/Animated.play("changescene")
		

func _on_animation_animation_finished(anim_name):
	match anim_name:
		"changescene":
			GLOBAL.level += 1
			print(GLOBAL.speed)
			GLOBAL.can_change = false
			get_tree().change_scene_to_file("res://Scenes/level3D.tscn")


func _on_insert_coin_pressed():
	if get_tree().paused:
		get_tree().paused = false
		$Scoreboard/MarginContainer/Pause.text = "PAUSA"
	else:
		get_tree().paused = true
		$Scoreboard/MarginContainer/Pause.text = "REANUDAR"
	
