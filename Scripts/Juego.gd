extends Node2D

onready var player = get_node("pacman")
onready var muros = get_node("Navigation2D/muros")

var Muros = []
var Monedas = []
var p_pos_ini = []
var e_pos_ini = []
var esp_blan = []
var vidas = 3
var tot_moned = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	cargar_archivo()
	


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
	for e in Monedas:
		muros.set_cellv(e, 12)
	
	

func cargar_archivo():
	print("Cargando archivo")
	var file = File.new()
	file.open("res://walls.txt", File.READ)
	
	var content = file.get_as_text()
	var cont_lines = content.split("\n")
	file.close()
	
	for i in range(cont_lines.size()):
		print(cont_lines[i])
		for j in range(cont_lines[i].length()):
			var let = cont_lines[i][j]
			if let == "1":
				Muros.append(Vector2(j, i))
			elif let == "C":
				Monedas.append(Vector2(j, i))
			elif let == "P":
				p_pos_ini = Vector2(j, i)
			elif let in ["2" , "3", "4"]: # , "5" // BFS, DFS, A*
				e_pos_ini.append(Vector2(j, i))
			elif let == "B":
				esp_blan.append(Vector2(j,i))
	tot_moned = Monedas.size()
	
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
	tot_moned = Monedas.size()
