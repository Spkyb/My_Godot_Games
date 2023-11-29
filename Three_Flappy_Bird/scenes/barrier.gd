extends Node2D
var SPEED = 3

signal die

func _physics_process(delta):
	position.x = move_toward(position.x, -47, SPEED)
