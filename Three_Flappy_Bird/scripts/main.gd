extends Node2D

@onready var player_scene : PackedScene = preload("res://scenes/player.tscn")
@onready var barrier_scene : PackedScene = preload("res://scenes/barrier.tscn")

func _ready():
	#随机数
	randomize()
	# 添加角色
	var player = player_scene.instantiate()
	player.position.x = get_viewport_rect().size.x / 5
	player.position.y = get_viewport_rect().size.y / 2
	add_child(player)
	add_barrier()
	player.die.connect(_on_ball_die)
func _process(delta):
	$ParallaxBackground.scroll_offset.x -= delta * 100
	
func add_barrier():
	var barrier = barrier_scene.instantiate()
	barrier.position.x = get_viewport_rect().size.x + 47
	barrier.position.y = get_viewport_rect().size.y/2 + (randf_range(-1,1) * 150)
	add_child(barrier)
	
func _on_ball_die():
	get_tree().reload_current_scene() # 重新加载场景

func _on_timer_timeout():
	add_barrier()
	$Timer.start()
