extends Node

@onready var Ball_scene : PackedScene = preload("res://scenes/ball.tscn")

var ball_direction = Vector2() # 球的运动方向
var player_direction = Vector2() # 玩家的移动方向
var ball : Node = null
var arena : Node = null
var score : int = 0
var high_score : int = 0
var can_add_score : bool = true

func _ready():
	randomize()#随机数
# 添加score
func add_score(value : int) -> void:
	score += value
	if arena != null:
		arena.get_node("HUD").set_score(score)
	if(score > high_score):
		high_score = score
		if arena != null:
			arena.get_node("HUD").set_highscore(score)
