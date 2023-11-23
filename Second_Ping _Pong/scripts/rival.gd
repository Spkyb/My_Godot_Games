extends Node2D
#外部可以直接修改的变量
@export var speed : int = 5

var vec = Vector2()
var screen_size

func _ready():
	# 获得屏幕尺寸
	screen_size = get_viewport_rect().size

func _process(delta):
	
	position += vec.normalized() * speed * delta * 80
	
	
	
	# 防止离开rival离开屏幕
	position.x = clamp(position.x, screen_size.x / 2 + 13, screen_size.x - 13)
	position.y = clamp(position.y, 39, screen_size.y - 39)
