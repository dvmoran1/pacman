#Class AStar

#class Nodo:
#	var pos
#	var padre
#	var h
#	var g
#
#	func _init( pos, destino_f, padre=null):
#			self.pos = pos
#			self.padre = padre
#			self.h = distancia(self.pos, destino_f)
#
#			if self.padre == null:
#				self.g = 0
#			else:
#				self.g = self.padre.g + 1
#			self.f = self.g + self.h
#
#	func distancia(a, b):
#		return abs(a[0] - b[0]) + abs(a[1] - b[1])



#class AEstrella:
var grid
var origen
var destino
var abierta
var cerrada
var select
var Nodo = load("res://Nodo.gd")
var nodos
var camino

func _init(grid, origen, destino):
	self.grid = grid

	self.origen = Nodo.new(origen, destino)
	self.destino = Nodo.new(destino, destino)

	self.abierta = []
	self.cerrada = []

	self.cerrada.append(self.origen)

	self.abierta += vecinos(self.origen)

	while self.objetivo():
		self.buscar()

	self.camino = self.camino()

func vecinos(nodo):
	var nodos = []
	var vecinos = [[0, -1], [1, 0], [0, 1], [-1, 0]]
	for vecino in vecinos:
		if vecino[0] + nodo.pos[0] >= 0 and vecino[0] + nodo.pos[0] < 28:
			if vecino[1] + nodo.pos[1] >= 0 and vecino[1] + nodo.pos[1] < 30:
				if self.grid[vecino[0] + nodo.pos[0]][vecino[1] + nodo.pos[1]] != 1:
					nodos.append(Nodo.new([vecino[0] + nodo.pos[0], vecino[1] + nodo.pos[1]], self.destino.pos, nodo))
	return nodos

func f_menor():
	var a = self.abierta[0]
	var n = 0
	for i in range(1, len(self.abierta)):
		if self.abierta[i].f < a.f:
			a = self.abierta[i]
			n = i
	self.cerrada.append(self.abierta[n])
	self.abierta.remove(n)

func en_lista(nodo, lista):
	for i in range(len(lista)):
		if nodo.pos == lista[i].pos:
			return 1
	return 0
	
func ruta():
	for i in range(len(self.nodos)):
		if self.en_lista(self.nodos[i], self.cerrada):
			continue
		elif not self.en_lista(self.nodos[i], self.abierta):
			self.abierta.append(self.nodos[i])
		else:
			if self.select.g + 1 < self.nodos[i].g:
				for j in range(len(self.abierta)):
					if self.nodos[i].pos == self.abierta[j].pos:
						self.abierta.remove(j)
						self.abierta.append(self.nodos[i])
						break

func buscar():
	self.f_menor()
	self.select = self.cerrada[-1]
	self.nodos = self.vecinos(self.select)
	self.ruta()

func objetivo():
	for i in range(len(self.abierta)):
		if self.destino.pos == self.abierta[i].pos:
			return 0
	return 1

func camino():
	var objetivo = []
	for i in range(len(self.abierta)):
		if self.destino.pos == self.abierta[i].pos:
			objetivo = self.abierta[i]

	var camino = []
	while objetivo.padre != null:
		camino.append(objetivo.pos)
		objetivo = objetivo.padre
		camino.invert()
	return camino
