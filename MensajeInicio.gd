extends CanvasLayer


signal iniciar_juego()

var show_mensaje = true
var en_inicio = true


func _ready():
	pass # Replace with function body.


func _process(delta):
	if en_inicio:
		if Input.is_action_just_pressed("ui_select"):
			emit_signal("iniciar_juego")
			$Timer.stop()
			$Titulo_Juego.hide()
			$Mensaje.hide()
			en_inicio = false

func _on_Timer_timeout():
	show_mensaje = !show_mensaje
	if show_mensaje:
		$Mensaje.hide()
	else:
		$Mensaje.show()

func win():
	$Mensaje.text ="has ganado"
	$Mensaje.show()
	$Restar_Timer.start()	

func lose():
	$Mensaje.text ="game over"
	$Mensaje.show()
	$Restar_Timer.start()

func _on_Restar_Timer_timeout():
	en_inicio = true
	$Mensaje.text = "presiona espacio"
	$Timer.start()
	$Titulo_Juego.show()
	$Life.text = "111"
	
