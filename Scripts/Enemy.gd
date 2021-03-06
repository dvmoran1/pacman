extends Area2D


onready var walls = get_parent().get_node("Navigation2D/muros")
onready var AEstrella = load("res://Scripts/AStar.gd")
var path = []
var direction = Vector2(0,0)
var SPEED = 50
var active = false
var numero = 0

signal game_over()

func _ready():
	pass


func _process(delta):
	if (active):
		position += SPEED *  delta * direction


func move():
	direction =  get_direccion(walls.get_grid_pos(position),walls.get_grid_pos(walls.player.position))
	
func get_direccion(origen, destino):
	
	var next_cell = find_next_cell_in_path([origen.x,origen.y],[destino.x,destino.y])
	
	var x = next_cell[0] - origen[0]
	var y = next_cell[1] - origen[1]
	return Vector2(x, y)

func find_next_cell_in_path(origen, destino):
	var grid = []
	for x in range(28):
		grid.append([])
		grid[x]=[]        
		for y in range(30):
			grid[x].append([])
			grid[x][y]=0
	for celda in walls.Muros:
		if celda.x < 28 and celda.y < 30:
			grid[int(celda.x)][int(celda.y)] = 1	
	if numero == 0:	
		var camino = BFS(origen, destino, grid)
		if(len(camino) > 1):
			return camino[1]
		else:
			return camino[0]
	elif numero == 1:
		var camino = DFS(origen,destino, grid,[],[])
		if camino:
			return camino[0]
		else:
			return origen
	elif numero == 2:
		var astar = AEstrella.new(grid,origen, destino)
		return astar.camino[0]
	else:
		return  BPI(origen, destino, grid)
			
func BFS(inicio, destino, grid):
		var cola = [inicio]
		var camino = []
		var visitado = []
		while cola:
			var actual = cola[0]
			cola.remove(0)
			visitado.append(actual)
			if actual == destino:
				break
			else:
				var vecinos = [[0, -1], [1, 0], [0, 1], [-1, 0]]
				for vecino in vecinos:
					if vecino[0]+actual[0] >= 0 and vecino[0] + actual[0] < len(grid): #Validamos X
						if vecino[1]+actual[1] >= 0 and vecino[1] + actual[1] < len(grid[0]): #Validamos Y
							var next_cell = [vecino[0] + actual[0], vecino[1] + actual[1]]
							if visitado.find(next_cell) == -1 : #No lo encontramos en visitados
								if grid[next_cell[0]][next_cell[1]] != 1: 
									cola.append(next_cell)
									camino.append({"Current": actual, "Next": next_cell})
		var ruta = [destino]
		while destino != inicio:
			for item in camino:
				if item["Next"] == destino:
					destino = item["Current"]
					ruta.insert(0, item["Current"])
		return ruta
		
func BPI(origen, destino, grid):
	var profundidad = 0
	while 1:
		var resultado = BPL(origen, destino, profundidad, grid, [])
		if resultado:
			return resultado
		profundidad = profundidad + 1
	
func BPL(actual, objetivo, profundidad, grid, visitados):
	if profundidad == 0 and actual == objetivo:
		return actual
	elif profundidad > 0 and visitados.find(actual) == -1:
		visitados.append(actual)
		var vecinos = [[0, -1], [1, 0], [0, 1], [-1, 0]]
		for vecino in vecinos:
			if vecino[0]+actual[0] >= 0 and vecino[0] + actual[0] < len(grid): #Validamos X
				if vecino[1]+actual[1] >= 0 and vecino[1] + actual[1] < len(grid[0]): #Validamos Y
					var next_cell = [vecino[0] + actual[0], vecino[1] + actual[1]]
					if grid[next_cell[0]][next_cell[1]] != 1:
						var resultado = BPL(next_cell, objetivo, profundidad-1, grid, visitados)
						if resultado:
							return next_cell
	else:
		return null
		
		
func DFS(inicio, destino, grid,solucion, visitados):
		if inicio == destino:
			return solucion
		else:
			if  visitados.find(inicio) == -1:
				visitados.append(inicio)
				var vecinos = [[1, 0], [0, -1], [-1, 0], [0, 1]]
				vecinos.shuffle()
				for vecino in vecinos:
					if (0 <= vecino[0] + inicio[0]) and vecino[0] + inicio[0] < len(grid): #Validamos x
						if 0 <= vecino[1] + inicio[1] and vecino[1] + inicio[1] < len(grid[0]): #Validamos y
							var next_cell = [vecino[0] + inicio[0], vecino[1] + inicio[1]]
							if grid[next_cell[0]][next_cell[1]] != 1:
								solucion.append(next_cell)
								DFS(next_cell, destino, grid, solucion, visitados)
								if solucion[-1] == destino:
									return solucion
								else:
									solucion.pop_back()



func _on_Enemy_area_entered(area):
	if(area.name == "pacman"):
		print("Game Over")
		emit_signal("game_over")
		

