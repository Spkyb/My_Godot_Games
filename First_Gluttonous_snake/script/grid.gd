class_name Grid # 申明类明，以便其它场景引用

extends TileMap

@export var line_color: Color #颜色
@export var line_thickness: int = 1 #粗细，单位是像素

@onready var grid_size = Vector2(32,19)#32*32=1064、19*32=608，刚刚好为窗口大小

signal eat_food(food_entity,entity)# 吃到食物信号
signal game_over()# 游戏结束信号


var grid : Array # 创建grid数组

# 将grid数组按网格数填满,初始化地图
func init_grid():
	grid = []
	for x in range(grid_size.x):
		grid.append([])# 向数组末尾追加一个元素（push_back() 的别名）
		for y in range(grid_size.y):
			grid[x].append(null)

# 画绘制网格边框
func _draw():
	for x in range(grid_size.x):
		var start_point: Vector2 = Vector2(x * tile_set.tile_size.x, 0)
		var end_point: Vector2 = Vector2(x * tile_set.tile_size.x, grid_size.y * tile_set.tile_size.y)
		draw_line(start_point,end_point,line_color,line_thickness)

	for y in range(grid_size.y):
		var start_point: Vector2 = Vector2(0, y * tile_set.tile_size.x)
		var end_point: Vector2 = Vector2(grid_size.x * tile_set.tile_size.x, y * tile_set.tile_size.y)
		draw_line(start_point,end_point,line_color,line_thickness)

#随便数获取到一个网格的位置时，需要先检查这一格是不是空(记得初始化时的null吗)，如果不是需要继续获取一个随机位置
func place_entity_at_random_pos(entity: Node2D):
	var has_random_pos: bool = false
	var random_grid_pos: Vector2
	#
	while has_random_pos == false:
		var temp_pos: Vector2 = Vector2(randf() * int(grid_size.x),randf() * int(grid_size.y))# randf()0-1
		if get_entity_of_cell(temp_pos) == null:
			random_grid_pos = temp_pos
			has_random_pos = true
	place_entity(entity,random_grid_pos)
	
#直接返回指定x,y的grid数组的数据，如果不为null，则已有实体
func get_entity_of_cell(grid_pos: Vector2):
	return grid[grid_pos.x][grid_pos.y] as Node2D

# 将grid数组里对应位置的值附上实体
# 将实体的position设置为网格的坐标
func place_entity(entity: Node2D, grid_pos: Vector2):
	set_entity_in_cell(entity, grid_pos)
	entity.set_position(map_to_local(grid_pos))# map_to_local返回单元格的中心位置

# 将grid数组里对应位置的值附上实体
func set_entity_in_cell(entity: Node2D, grid_pos: Vector2):
	grid[grid_pos.x][grid_pos.y] = entity

# 移动蛇头，需要按方向移动
func move_entity_in_direction(entity: Node2D, direction: Vector2):
	var old_grid_pos: Vector2 = local_to_map(entity.position)
	var new_grid_pos: Vector2 = old_grid_pos + direction # 它原来位置加上direction，direction是一个向量，所以它是有方向的
	# 碰到边界
	if !is_cell_inside_bounds(new_grid_pos):
		emit_signal("game_over")
		
		return
	#吃到食物，先判断是否有食物，再进行下一步
	var entity_of_new_cell: Node2D = get_entity_of_cell(new_grid_pos)
	
	if entity_of_new_cell != null:
		if entity_of_new_cell.is_in_group("Food"):# 实体是Food分组里面
			emit_signal("eat_food",entity_of_new_cell,entity)
		elif entity_of_new_cell.is_in_group("Snake"):# 实体是Snake分组里面
			init_grid()#清空所有格子，初始化地图数据
			emit_signal("game_over")
	#
	set_entity_in_cell(null, old_grid_pos)# 将指定位置的数组值清空（null）
	place_entity(entity, new_grid_pos)# 将实体放置到新的位置上
	
# 移动身体
func move_entity_to_position(entity: Node2D, direction: Vector2):
	var old_grid_pos: Vector2 = local_to_map(entity.position)
	var new_grid_pos: Vector2 = local_to_map(direction)
	#
	set_entity_in_cell(null, old_grid_pos)#将 指定位置的数组值清空（null）
	place_entity(entity, new_grid_pos)# 将实体放置到新的位置上

# 蛇头出了边界的判断
func is_cell_inside_bounds(cell_pos:Vector2):
	if cell_pos.x < grid_size.x and cell_pos.y >= 0 and cell_pos.y < grid_size.y and cell_pos.x >= 0:
		return true
	else: 
		return false
func _ready():
	init_grid()
