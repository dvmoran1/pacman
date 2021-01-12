extends CanvasLayer


signal iniciar_juego()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var show_mensaje = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		emit_signal("iniciar_juego")
		$Timer.stop()
		$Titulo_Juego.hide()
		$Mensaje.hide()

func _on_Timer_timeout():
	show_mensaje = !show_mensaje
	if show_mensaje:
		$Mensaje.hide()
	else:
		$Mensaje.show()
