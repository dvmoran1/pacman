extends TileMap

onready var half_cell_size = get_cell_size()/2
onready var player = get_parent().get_parent().get_node("pacman")
onready var enemy = get_parent().get_parent().get_node("Enemy")
onready var enemy2 = get_parent().get_parent().get_node("Enemy2")
onready var score = get_parent().get_parent().get_node("Inicio").get_child(2)
onready var padre = get_parent().get_parent()
var ganar = false

signal juego_ganado()

func _ready():
	enemy.position =  get_enemy_pos(1,1)
	enemy2.position =  get_enemy_pos(16,13)
	
func get_player_init_pos():
	var pos = map_to_world(Vector2(14,23))
	pos.y += half_cell_size.y
	pos.x += half_cell_size.x
	return pos
	
func is_tile_vacant(pos, direction):
	var curr_tile = world_to_map(pos)
	var next_tile = get_cellv(curr_tile + direction)
	var next_tile_pos = Vector2()
	if(next_tile == 12 or next_tile == 13 or next_tile == 14):
		next_tile_pos = map_to_world(curr_tile + direction) + half_cell_size
	else:
		next_tile_pos = relocate(pos)
	return next_tile_pos
	
func relocate(pos):
	var tile = world_to_map(pos)
	return map_to_world(tile) + half_cell_size
		

func eat(pos):
	var curr_tile = world_to_map(pos)
	var tile = get_cellv(curr_tile)
	if(tile == 12 or tile == 13):
		set_cellv(curr_tile, 14)
		

func _process(delta):
	if (!ganar):
		var count = 0
		for i in range(get_used_rect().size.x):
			for j in range(get_used_rect().size.y):
				var tile = get_cell(i,j)
				if(tile == 12):
					count += 1
		score.text = String((padre.tot_moned+1 - count)*10)
		if(count == 0):
			ganar = true
			emit_signal("juego_ganado")


func get_enemy_pos(x,y):
	var pos = map_to_world(Vector2(x,y)) #found through trial and error
	pos.y += half_cell_size.y
	pos.x += half_cell_size.x
	return pos

func get_path_to_player():
	var path = get_parent().get_simple_path(enemy.position, player.position, false)
	return path
	
