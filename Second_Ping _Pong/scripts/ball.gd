extends Node2D

#外部可以直接修改的变量
@export var speed : int = 5

func _ready():
	# 随机给球一个方向
	Global.ball_direction.x = randf_range(-1,1)
	Global.ball_direction.y = randf_range(-1,1)
	
func _process(delta):
	
	position += Global.ball_direction.normalized() * speed * delta * 80

# 碰到player或者边界反弹ball
func _on_area_2d_area_entered(area):
	if area.is_in_group("player") || area.is_in_group("boundary_left_or_right"):
		Global.ball_direction.x= -Global.ball_direction.x
	if area.is_in_group("boundary_up_or_down"):
		Global.ball_direction.y = -Global.ball_direction.y

