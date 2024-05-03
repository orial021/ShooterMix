extends Control

func _ready() -> void:
	GLOBAL.score = 0
	GLOBAL.life = 1
	GLOBAL.points = 0
	GLOBAL.speed = 3
	GLOBAL.level = 1
	

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Scenes/level.tscn")


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
