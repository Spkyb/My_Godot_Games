extends Node2D
var SPEED = 3

func _physics_process(delta):
	position.x = move_toward(position.x, -47, SPEED)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
