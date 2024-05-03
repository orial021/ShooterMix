extends CanvasLayer

func _ready() -> void:
	$Scoreboard/ColorRect.visible = false
	
func _process(_delta):
	%Credits.text = "SPACESHIPS: " + str(GLOBAL.life)
	%Score.text = "SCORE: " + str(GLOBAL.score)
	if GLOBAL.score % 1000 == 0 and GLOBAL.score != 0:
		$Scoreboard/ColorRect.visible = true
		$Scoreboard/ColorRect/Animation.play("change_scene")
		

func _on_animation_animation_finished(anim_name):
	match anim_name:
		"change_scene":
			get_tree().change_scene_to_file("res://Scenes/level3D.tscn")


func _on_insert_coin_pressed():
	if get_tree().paused:
		get_tree().paused = false
		$Scoreboard/MarginContainer/Pause.text = "PAUSA"
	else:
		get_tree().paused = true
		$Scoreboard/MarginContainer/Pause.text = "REANUDAR"
	
