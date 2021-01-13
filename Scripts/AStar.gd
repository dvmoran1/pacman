extends Node


class_name AEstrella

var grid
var origen
var destino
var abierta
var cerrada
var select
var Nodo = load("res://Scripts/Nodo.gd")
var nodos
var camino

func _init(p_grid, p_origen, p_destino):
	self.grid = p_grid

	self.origen = Nodo.new(p_origen, p_destino)
	self.destino = Nodo.new(p_destino, p_destino)

	self.abierta = []
	self.cerrada = []

	self.cerrada.append(self.origen)

	self.abierta += vecinos(self.origen)

	while self.objetivo():
		self.buscar()

	self.camino = self.encontrar_camino()

func vecinos(p_nodo):
	var p_nodos = []
	var vecinos = [[0, -1], [1, 0], [0, 1], [-1, 0]]
	for vecino in vecinos:
		if vecino[0] + p_nodo.pos[0] >= 0 and vecino[0] + p_nodo.pos[0] < 28:
			if vecino[1] + p_nodo.pos[1] >= 0 and vecino[1] + p_nodo.pos[1] < 30:
				if self.grid[vecino[0] + p_nodo.pos[0]][vecino[1] + p_nodo.pos[1]] != 1:
					p_nodos.append(Nodo.new([vecino[0] + p_nodo.pos[0], vecino[1] + p_nodo.pos[1]], self.destino.pos, p_nodo))
	return p_nodos

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

func encontrar_camino():
	var objetivo = []
	for i in range(len(self.abierta)):
		if self.destino.pos == self.abierta[i].pos:
			objetivo = self.abierta[i]

	var p_camino = []
	while objetivo.padre != null:
		p_camino.append(objetivo.pos)
		objetivo = objetivo.padre
		p_camino.invert()
	return p_camino
