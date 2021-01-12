extends Node2D


var Muros = []
var Monedas = []
var p_pos_ini = []
var e_pos_ini = []
var esp_blan = []

# Called when the node enters the scene tree for the first time.
func _ready():
	cargar_archivo()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Inicio_iniciar_juego():
	$Enemy.active = true
	$Enemy2.active = true
	$pacman.active = true
	

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
	

