#Clase Nodo

var pos
var padre
var h
var g
var f

func _init( pos, destino_f, padre=null):
		self.pos = pos
		self.padre = padre
		self.h = distancia(self.pos, destino_f)

		if self.padre == null:
			self.g = 0
		else:
			self.g = self.padre.g + 1
		self.f = self.g + self.h

func distancia(a, b):
	return abs(a[0] - b[0]) + abs(a[1] - b[1])
