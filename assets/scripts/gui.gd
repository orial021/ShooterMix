extends CanvasLayer

func _ready() -> void:
	$Control/Fade/AnimationPlayer.play("fade_in")
	
func _process(_delta) -> void:
	%Score.set_text("SCORE: " + str(GLOBAL.points))
	%Lifes.set_text("SPACESHIPS: " + str(GLOBAL.life))
	%Level.set_text("LEVEL " + str(GLOBAL.level))
	if GLOBAL.points % 100 == 0 and GLOBAL.can_change:
		$Control/Fade/Animation.play("change_scene")


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_out":
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
			

func _on_animation_animation_finished(anim_name):
	match anim_name:
		"change_scene":
			GLOBAL.level += 1
			print(GLOBAL.speed)
			GLOBAL.can_change = false
			get_tree().change_scene_to_file("res://Scenes/level.tscn")
