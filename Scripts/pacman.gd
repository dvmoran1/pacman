extends Area2D

var direction = Vector2(0,0)
var SPEED = 10
onready var walls = get_parent().get_node("Navigation2D/muros")

func _ready():
	$AnimatedSprite.play("comiendo")
	position = walls.get_player_init_pos()

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		direction = Vector2(0,-1)
		rotation = deg2rad(-90)
	if Input.is_action_pressed("ui_down"):
		direction = Vector2(0,1)
		rotation = deg2rad(90)
	if Input.is_action_pressed("ui_left"):
		direction = Vector2(-1,0)
		rotation = deg2rad(180)
	if Input.is_action_pressed("ui_right"):
		direction = Vector2(1,0)
		rotation = deg2rad(0)

	#position+= SPEED*direction*delta
	var pos_to_move = walls.is_tile_vacant(position, direction)
	if(direction != Vector2(0,0)):
		position = position.linear_interpolate(pos_to_move, SPEED * delta)
		walls.eat(position)