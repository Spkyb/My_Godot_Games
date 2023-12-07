extends CharacterBody2D

const SPEED = 300.0 # 速度
const JUMP_VELOCITY = -350.0 

signal die

# 从项目设置中获取要与player同步的重力
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# 如果没有碰到地面就增加重力.
	if not is_on_floor():# 
		velocity.y += gravity * delta
	# 设置物体跳跃
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
	# 移动角色，代替对position的使用
	move_and_slide()

func _on_area_2d_area_entered(area):
	emit_signal("die")
