extends Node

@onready var Ball_scene : PackedScene = preload("res://scenes/ball.tscn")

var ball_direction = Vector2() # 球的运动方向
var ball
func _ready():
	randomize()#随机数
	
