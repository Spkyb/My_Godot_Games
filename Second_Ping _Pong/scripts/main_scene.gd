extends Node2D

@onready var player_scene : PackedScene = preload("res://scenes/player.tscn")
@onready var Rival_scene : PackedScene = preload("res://scenes/rival.tscn")

func _ready():
	# 初始化score
	Global.arena = self
	Global.score = 0
	$HUD.set_highscore(Global.high_score)
	# 添加角色
	var player = player_scene.instantiate()
	player.position.x = get_viewport_rect().size.x / 8
	player.position.y = get_viewport_rect().size.y / 2
	add_child(player)
	# 添加乒乓球
	add_ball_child()
	# 添加AI对手
	var rival = Rival_scene.instantiate()
	rival.position.x = get_viewport_rect().size.x - player.position.x
	rival.position.y = get_viewport_rect().size.y / 2
	add_child(rival)
	
func _process(_delta):
	# 按下esc关闭游戏
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	pass
	
# 添加乒乓球
func add_ball_child():
	Global.ball = Global.Ball_scene.instantiate()
	Global.ball.position = get_viewport_rect().size / 2
	add_child(Global.ball)
	# 乒乓球的信号接收
	Global.ball.die.connect(_on_ball_die)
	Global.ball.player_win.connect(_on_ball_player_win)

func _on_ball_die():
	get_tree().reload_current_scene() # 重新加载场景

func _on_ball_player_win():
	Global.ball.queue_free()
	add_ball_child()
	
	
