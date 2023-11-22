extends Node2D

@onready var scene_snake : PackedScene = preload("res://scenes/Snake.tscn")
@onready var scene_food : PackedScene = preload("res://scenes/Food.tscn")

@onready var grid: Grid = get_node("Grid")

# 蛇实例化代码
func init_entities():
	var snake = scene_snake.instantiate()# 实例化
	snake.snake_move_triggered.connect(_on_Snake_move_triggered)
	snake.body_segment_move_triggered.connect(_on_Snake_body_segment_move_triggered)
	snake.generated_tail_segment.connect(_on_Snake_generated_tail_segment)
	add_child(snake)
	grid.place_entity_at_random_pos(snake)
	init_food()

# 蛇头移动函数，信号连接函数，调用grid的move_entity_in_direction函数代码
func _on_Snake_move_triggered(entity: Node2D, direction: Vector2):
	grid.move_entity_in_direction(entity, direction)

# 蛇身移动，信号连接函数，调用grid的move_entity_to_position函数代码
func _on_Snake_body_segment_move_triggered(segment: Node2D, segement_pos: Vector2):
	grid.move_entity_to_position(segment, segement_pos)

# 吃到食物，添加蛇身，信号连接函数，添加child，调用grid的place_entity函数代码
func _on_Snake_generated_tail_segment(segment: Node2D, segment_pos: Vector2):
	add_child(segment)
	grid.place_entity(segment, grid.local_to_map(segment_pos))

# 食物生成代码
func init_food():
	var food = scene_food.instantiate()
	add_child(food)
	grid.place_entity_at_random_pos(food)

func _ready():
	Global.arena = self
	init_entities()
	Global.score = 0
	$HUD.set_highscore(Global.high_score)

func _process(_delta):
	# 如果按下esc,退出游戏
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	pass

# 接收到吃到食物信号的应激函数
func _on_grid_eat_food(food_entity, entity):
	if entity.has_method("eat_food"):
		entity.eat_food()
		food_entity.queue_free()
		Global.add_score(1)
		init_food()

# 接收到游戏结束信号的应激函数
func _on_grid_game_over():
	#var entites: Array = get_tree().get_nodes_in_group("Snake")
	#for entity in entites:
		#entity.queue_free()
	get_tree().reload_current_scene() # 重新加载场景

	
