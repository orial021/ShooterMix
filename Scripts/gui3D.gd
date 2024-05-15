extends CanvasLayer

func _ready() -> void:
	$Control/Fade/AnimationPlayer.play("fade_in")
	$Control/MarginContainer/Pause.get_popup().connect("id_pressed", Callable(self, "_on_pause_item_selected"))
	
	
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

func _on_up_button_down():
	Input.action_press("ui_up")
	
func _on_up_button_up():
	Input.action_release("ui_up")

func _on_left_button_down():
	Input.action_press("ui_left")

func _on_left_button_up():
	Input.action_release("ui_left")
	
func _on_shot_button_down():
	Input.action_press("ui_accept")
	GLOBAL.is_shot = true
	print("presionado")
	
func _on_shot_button_up():
	Input.action_release("ui_accept")
	GLOBAL.is_shot = false
	print("release")
	
func _on_right_button_down():
	Input.action_press("ui_right")
	
func _on_right_button_up():
	Input.action_release("ui_right")

func _on_down_button_down():
	Input.action_press("ui_down")

func _on_down_button_up():
	Input.action_release("ui_down")


func _on_pause_item_selected(id):
	match id:
		-1: #pause
			get_tree().paused = true
		0: #reanudar
			get_tree().paused = false
		1: #guardar
			GLOBAL.save_game()
			print("juego guardado")
		2: # menu
			get_tree().paused = false
			get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
func _on_pause_about_to_popup():
	#if get_tree().paused:
		#get_tree().paused = false
		#$Control/MarginContainer/Pause.text = "PAUSA"
	#else:
	get_tree().paused = true
		#$Control/MarginContainer/Pause.text = "REANUDAR"
