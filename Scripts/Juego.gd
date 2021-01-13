extends Node2D

onready var player = get_node("pacman")
onready var muros = get_node("Navigation2D/muros")


var vidas = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Inicio_iniciar_juego():
	$Enemy.active = true
	$EnemyBlue.active = true
	$EnemyOrange.active = true
	player.active = true
	#Agregar_puntos
	muros.ganar = false
	for e in muros.Monedas:
		muros.set_cellv(e, 12)
	
	

func _on_muros_juego_ganado():
	print("Juego ganado")
	juego_terminado()
	reposicionar()
	$Inicio.win()

func _on_Enemy_game_over():
	vidas -= 1
	reposicionar()
	if vidas == 2:
		$Inicio/Life.text = "11"
	elif vidas == 1:
		$Inicio/Life.text = "1"
	elif vidas == 0:
		$Inicio/Life.text = ""
		juego_terminado()
		$Inicio.lose()

func reposicionar():
	$pacman.position = muros.get_player_init_pos()
	$Enemy.position = muros.get_enemy_pos(1,1)
	$EnemyBlue.position =  muros.get_enemy_pos(15,1)
	$EnemyOrange.position =  muros.get_enemy_pos(14,11)
	

func juego_terminado():
	$Enemy.active = false
	$EnemyBlue.active = false
	$EnemyOrange.active = false
	player.active = false
	vidas = 3
	muros.tot_moned = muros.Monedas.size()
