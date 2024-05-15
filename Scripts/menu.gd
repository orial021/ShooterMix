extends Control

func _ready() -> void:
	$Fade/AnimationPlayer.play("Fade_in")

func _on_start_pressed() -> void:
	get_tree().paused = false
	#GLOBAL.start()
	$Fade/AnimationPlayer.play("Fade_out")

func _on_exit_pressed():
	get_tree().quit() 


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Fade_out":
			get_tree().change_scene_to_file("res://Scenes/level.tscn")


func _on_load_pressed():
	get_tree().paused = false
	GLOBAL.load_game()
	if GLOBAL.level % 2 == 0 and GLOBAL.level != 0:
		GLOBAL.load_game()
		GLOBAL.score = GLOBAL.game_data["score"]
		GLOBAL.life = GLOBAL.game_data["life"]
		GLOBAL.points = GLOBAL.game_data["points"]
		GLOBAL.level = GLOBAL.game_data["level"]
		GLOBAL.bullets = GLOBAL.game_data["bullets"]
		GLOBAL.speed = GLOBAL.game_data["speed"]
		get_tree().change_scene_to_file("res://Scenes/level3D.tscn")
	else:
		GLOBAL.load_game()
		GLOBAL.score = GLOBAL.game_data["score"]
		GLOBAL.life = GLOBAL.game_data["life"]
		GLOBAL.points = GLOBAL.game_data["points"]
		GLOBAL.level = GLOBAL.game_data["level"]
		GLOBAL.bullets = GLOBAL.game_data["bullets"]
		GLOBAL.speed = GLOBAL.game_data["speed"]
		get_tree().change_scene_to_file("res://Scenes/level.tscn")


func _on_save_pressed():
	GLOBAL.save_game()
