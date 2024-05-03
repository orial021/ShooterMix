extends Control

func _ready() -> void:
	$Fade/AnimationPlayer.play("Fade_in")

func _on_start_pressed() -> void:
	$Fade/AnimationPlayer.play("Fade_out")

func _on_exit_pressed():
	get_tree().quit() 


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Fade_out":
			get_tree().change_scene_to_file("res://Scenes/level.tscn")
