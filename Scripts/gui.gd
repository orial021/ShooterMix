extends CanvasLayer

@onready var menu_button = $Scoreboard/MarginContainer/Pause 

func _ready() -> void:
	$Scoreboard/ColorRect.visible = false
	menu_button.get_popup().connect("id_pressed", Callable(self, "_on_menu_item_selected"))
	
	
func _process(_delta):
	%Credits.text = "SPACESHIPS: " + str(GLOBAL.life)
	%Score.text = "SCORE: " + str(GLOBAL.score)
	$Scoreboard/MarginContainer/Level.text = "level " + str(GLOBAL.level)
	$Scoreboard/MarginContainer/Bullets.text = "BULLETS: " + str(GLOBAL.bullets)
	
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
	
func _on_pause_about_to_popup():
	pass # Replace with function body.

func _on_menu_item_selected(id):
	match id:
		0: # Reanudar
			get_tree().paused = false
		1: # Guardar
			GLOBAL.save_game()
			print("juego guardado")
		2: # Salir
			get_tree().change_scene_to_file("res://Scenes/menu.tscn")

