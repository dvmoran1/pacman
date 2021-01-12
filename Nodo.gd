
extends Node

class_name Nodo

var pos
var padre
var h
var g
var f

func _init( p_pos, p_destino_f, p_padre=null):
		self.pos = p_pos
		self.padre = p_padre
		self.h = distancia(self.pos, p_destino_f)

		if self.padre == null:
			self.g = 0
		else:
			self.g = self.padre.g + 1
		self.f = self.g + self.h

func distancia(a, b):
	return abs(a[0] - b[0]) + abs(a[1] - b[1])
