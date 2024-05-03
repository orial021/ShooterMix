extends Node

var score : int = 0
var life : int = 1
var points : int = 0
var speed : int = 3
var level : int = 1
var axis : Vector2
var can_change : bool = false


func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized()
