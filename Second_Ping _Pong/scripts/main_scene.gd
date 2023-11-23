extends Node2D

@onready var player_scene : PackedScene = preload("res://scenes/player.tscn")

@onready var Rival_scene : PackedScene = preload("res://scenes/rival.tscn")



func _ready():
	# 添加角色
	var player = player_scene.instantiate()
	player.position.x = get_viewport_rect().size.x / 8
	player.position.y = get_viewport_rect().size.y / 2
	add_child(player)
	# 添加乒乓球
	Global.ball = Global.Ball_scene.instantiate()
	Global.ball.position = get_viewport_rect().size / 2
	add_child(Global.ball)
	# 添加AI对手
	var rival = Rival_scene.instantiate()
	rival.position.x = get_viewport_rect().size.x - player.position.x
	rival.position.y = get_viewport_rect().size.y / 2
	add_child(rival)
	
	
