extends Node2D

@onready var scene_shake : PackedScene = preload("res://scenes/Snake.tscn")
@onready var scene_food : PackedScene = preload("res://scenes/Food.tscn")

@onready var grid: Grid = get_node("Grid")

func init_entities():
	var snake = scene_shake.instantiate()# 实例化
	
	snake.snake_move_triggered.connect(_on_Snake_move_triggered)
	snake.body_segment_move_triggered.connect(_on_Snake_body_segment_move_triggered)
	snake.generated_tail_segment.connect(_on_Snake_generated_tail_segment)
	add_child(snake)
	grid.place_entity_at_random_pos(snake)
	init_food()

func _on_Snake_move_triggered(entity: Node2D, direction: Vector2):
	grid.move_entity_in_direction(entity, direction)

func _on_Snake_body_segment_move_triggered(segment: Node2D, segement_pos: Vector2):
	grid.move_entity_to_position(segment, segement_pos)

func _on_Snake_generated_tail_segment(segment: Node2D, segment_pos: Vector2):
	add_child(segment)
	grid.place_entity(segment, grid.local_to_map(segment_pos))

func init_food():
	var food = scene_food.instantiate()
	add_child(food)
	grid.place_entity_at_random_pos(food)

func _ready():
	init_entities()

func _on_grid_eat_food(food_entity, entity):
	if entity.has_method("eat_food"):
		entity.eat_food()
		food_entity.queue_free()
		init_food()
