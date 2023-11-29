extends Node2D

#外部可以直接修改的变量
@export var speed : int = 5

var screen_size
var vec = Vector2()

func _ready():
	# 获得屏幕尺寸
	screen_size = get_viewport_rect().size

func _process(delta):
	vec.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	vec.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	Global.player_direction = vec.normalized()
	position += Global.player_direction * speed * delta * 80
	
	# 防止离开player离开屏幕
	position.x = clamp(position.x, 13, screen_size.x / 2 - 13)
	position.y = clamp(position.y, 39, screen_size.y - 39)
