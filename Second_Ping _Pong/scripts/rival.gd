extends Node2D
#外部可以直接修改的变量
@export var speed : int = 5

var vec = Vector2()
var screen_size


func _ready():
	# 获得屏幕尺寸
	screen_size = get_viewport_rect().size

func _process(delta):
	if Global.ball_direction.x >= 0:
		rival_move(delta)
	# 防止离开rival离开屏幕
	position.x = clamp(position.x, screen_size.x / 2 + 13, screen_size.x - 13)
	position.y = clamp(position.y, 39, screen_size.y - 39)

func rival_move(delta):
	var ball_x_distance = position.x - Global.ball.position.x
	var ball_y_distance = position.y - Global.ball.position.y
	var ball_direction_y_distance = ball_x_distance * Global.ball_direction.y / Global.ball_direction.x
	vec.y = ball_direction_y_distance - ball_y_distance
	if abs(vec.y) > 10 :# 防止rival抖动
		position += vec.normalized() * speed * delta * 80
