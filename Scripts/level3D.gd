extends Node3D

@export var enemy : PackedScene
@export var extra_life : PackedScene

var SPEED = 2 + GLOBAL.level


func _ready() -> void:
	$Settings/Timer.start()

func _process(delta):
	$Settings/Path3D/PathFollow3D.set_progress($Settings/Path3D/PathFollow3D.get_progress() + SPEED * delta)


func _on_timer_timeout() -> void:
	var enemy_instance = enemy.instantiate()
	add_child(enemy_instance)
	enemy_instance.set_global_position($Settings/Path3D/PathFollow3D.get_global_position())
	
	
func _on_timer_2_timeout() -> void:
	var extra_life_instance = extra_life.instantiate( )
	add_child(extra_life_instance)
	extra_life_instance.set_global_position($Settings/Path3D/PathFollow3D.get_global_position())

 
