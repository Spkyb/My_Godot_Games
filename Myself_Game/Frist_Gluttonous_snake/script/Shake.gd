class_name Shake

extends Node2D

@onready var direction = Vector2() # 移动的方向
@onready var body_segments: Array = [self] # 蛇身数组
@onready var can_move: bool = false

const scene_tail = preload("res://scenes/Tail.tscn")

signal snake_move_triggered(entity, direction)
signal body_segment_move_triggered(segment, segment_pos)
signal generated_tail_segment(segment, segment_pos)


func _input(event):
	if event.is_action_pressed("ui_up"):
		direction = Vector2(0, -1)
	elif event.is_action_pressed("ui_down"):
		direction = Vector2(0, 1)
	elif event.is_action_pressed("ui_left"):
		direction = Vector2(-1, 0)
	elif event.is_action_pressed("ui_right"):
		direction = Vector2(1, 0)

func _process(delta):
	if direction != Vector2() and can_move:# 只有direction有值时再执行。游戏刚开始，没有按下任何方向键时，snake是不动的
		can_move = false
		var pre_segment_pos: Vector2 = self.position # 前一实体的位置。每遍历一个实体就将它当前的位置附与它，这样下一个实体就知道自己应该往哪里去
		for i in range(body_segments.size()):
			var temp_pos: Vector2 = Vector2()
			if i == 0:# 当处理第一个实体（蛇头）时，发送信号，移动蛇头
				emit_signal("snake_move_triggered", body_segments[i], direction)
			else :# 当处理身体各实体时，发送信号，移动蛇身
				temp_pos = body_segments[i].position
				emit_signal("body_segment_move_triggered", body_segments[i], pre_segment_pos)
				pre_segment_pos = temp_pos
		# 延时移动
		$MoveDelay.start()

func eat_food():
	var tail_segment = scene_tail.instantiate()
	body_segments.append(tail_segment)# 将实例化后的场景添加在后面
	#
	emit_signal("generated_tail_segment", tail_segment, body_segments[-2].position)
	pass
	
func _on_move_delay_timeout():
	can_move = true
