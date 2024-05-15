extends Node

var score : int = 0
var life : int = 1
var points : int = 0
var speed : int = 3
var level : int = 1
var axis : Vector2
var can_change : bool = false
var is_shot : bool = false
var bullets : int = 8
var save_path = "user://save_game.dat"
var game_data : Dictionary = {
	"score" : 0,
	"life" : 100,
	"points" : 0,
	"level" : 0,
	"bullets" : 0,
	"speed" : 0
}
#
#func start() -> void:
	#score = 0
	#life = 1
	#points = 0
	#speed = 3
	#level = 1
	#bullets = 8
	
func save_game() -> void:
	game_data["score"] = score
	game_data["life"] = life
	game_data["points"] = points
	game_data["level"] = level
	game_data["bullets"] = bullets
	game_data["speed"] = speed
	
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_file.store_var(game_data)
	print("juego guardado")
	save_file = null

func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		
		game_data = save_file.get_var()
		print("juego cargado")
		save_file = null
		
		
func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized()
	

	

	
