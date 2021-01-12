extends Area2D


onready var walls = get_parent().get_node("Navigation2D/muros")
var path = []
var direction = Vector2(0,0)
var SPEED = 5
var active = false

var x = randi() % 20
var y = randi() % 20

func _ready():
	position = walls.get_enemy_pos(1,5)
	path = walls.get_path_to_player()



func _process(delta):
	if (active):
		SPEED = 25
		if(path.size() > 1):
			var pos_to_move = path[0]
			direction = (pos_to_move - position).normalized()
			var distance = position.distance_to(path[0])
			if(distance > 1):
				position += SPEED * delta * direction
			else:
				path.remove(0)
		else:
			path = walls.get_path_to_player()
	
	#	Para mover el fantasma
	#	direction = Vector2(1,0)
	#	var pos_to_move = walls.is_tile_vacant(position, direction)
	#	if(direction != Vector2(0,0)):
	#		position = position.linear_interpolate(pos_to_move, SPEED * delta)
	




func _on_Enemy_area_entered(area):
	if(area.name == "pacman"):
		print("Game Over")
