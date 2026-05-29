extends Node2D


var _roullete_rounds =5
var _curso_actual = 0
var _ruleta_velocidad :int
var puede_moverse_ruleta: bool = false
var rate= 20.0
var _selected_area: Area2D = null
var encendido= true

var ocul_rule = true
var ocul_pre = true
var ocul_inter=false
var botton =true
var rule =true
var sscore=true

func  funcion():
	conectar()
	rule_re()

func rule_re():#Se renueva los valores
	encendido=true
	_roullete_rounds =5
	_curso_actual = 0
	randomize()
	_ruleta_velocidad=randf_range(850,950)
	puede_moverse_ruleta = false
	rate= 20.0

func princi():#Para mostrar el principio
	$Principio/jugar.show()
	$Principio/titulo.show()

func ocultarpre():#Para ocultar las preguntas
	if ocul_pre==true:
		$agua.hide()
		$artico.hide()
		$Cielo.hide()
		$bosque.hide()
		$jungla.hide()
		$sabana.hide()
		$comenzar.hide()
		ocul_pre =false

func ocultar_rule():#Para mostrar u ocultar la ruleta , segun coresponda
	
	if ocul_rule==true:
		$SpriteRuleta.hide()
		$Button.hide()
		$AreaManecilla.hide()
		$corectas.hide()
		$corectas.hide()
		$puntos.hide()
		#$puntomax.hide()
	if ocul_rule==false:
		$corectas.show()
		$SpriteRuleta.show()
		$Button.show()
		$AreaManecilla.show()	
		$corectas.show()
		$puntos.show()
		#$puntomax.show()

func ocult_inter():#Es una intermediacion entre la ruleta y la pregunta
	$tipo.text =_selected_area.name
	$comenzar.text="COMENZAR"
	if ocul_inter==true:
		$comenzar.hide()
		$tipo.hide()

	if ocul_inter==false:
		$tipo.show()
		$comenzar.show()

func score():
	Global.mejorpun()
	if sscore==true:
		$puntos.text=str(Global.puntos)
		#$puntomax.text=str(Global.smax)
	if sscore==false:
		$puntos.text=str(Global.puntos)
		#$puntomax.text=str(Global.smax)

func numram():#Genera un numero aleatorio
	randomize()
	_ruleta_velocidad=randf_range(900,1000)

func iniciar_juego():#Inicia el juego
	ocul_rule=false
	$Principio.mostrar_mensaje("preparado")


func _process(delta: float) :#Funcion para mover la ruleta
	conectar()
	ocultar_rule()
	ocultarpre()
	if puede_moverse_ruleta:
		if _ruleta_velocidad > 0 and $Timer.is_stopped():
			_ruleta_velocidad -= 1
		if _ruleta_velocidad > 0:
			_speed_up_roullete(delta)

func _speed_up_roullete(delta: float):#Para poder rotar la ruleta
	$SpriteRuleta.rotation_degrees += _ruleta_velocidad * delta

func _on_Button_pressed():#Boton para poder comenzar a girar la ruleta
	if encendido==true:
		encendido=false
		_start_roullete()
		numram()
		$AudioRuleta.play()
		botton=false

func _start_roullete() :	#Da el permiso para mover la ruleta
	for node in $SpriteRuleta.get_children():
		for child in node.get_children():
			child.disabled = false
			#CollisionPolygon2D.disabled = false
		
	puede_moverse_ruleta = true
	$Timer.start()
 
func _on_Timer_timeout() :#Funcion que permite que la ruleta se detenga de a poco
	_curso_actual+= 1
	if _ruleta_velocidad>=100:
		_ruleta_velocidad = _ruleta_velocidad - (rate * _ruleta_velocidad) / 65#<--- es 70 
	if _ruleta_velocidad<=100:
		_ruleta_velocidad = _ruleta_velocidad - (rate * _ruleta_velocidad) / 64

	if _ruleta_velocidad <= 20:
		_ruleta_velocidad=0
		$AudioRuleta.stop()
		if Global.solu==false:
			
			rule_re()
			Global.solu=true
		if botton==false:
			
			$time_ruleta.start()
			botton=true


func _on_AreaManecilla_area_entered(area: Area2D) -> void:#colicion de la maneciila
	_selected_area = area

func _on_comenzar_pressed():#Muetra las preguntas
	ocul_inter=true
	ocult_inter()#Oculta el intermediario
	if $tipo.text =="mar":
		ocul_rule=true
		ocultar_rule()#Oculta la ruleta
		$agua.show()#Muestra la pregunta
	if $tipo.text == "savana":
		ocul_rule=true
		ocultar_rule()
		$sabana.show()
	if $tipo.text == "bosque":
		ocul_rule=true
		ocultar_rule()
		$bosque.show()
	if $tipo.text == "jungla":
		ocul_rule=true
		ocultar_rule()
		$jungla.show()
	if $tipo.text == "artico":
		ocul_rule=true
		ocultar_rule()
		$artico.show()
	if $tipo.text == "Cielo":
		ocul_rule=true
		ocultar_rule()
		$Cielo.show()

func conectar():#Conecta la pregunta al interfaz o a la ruleta, segun coresponda
	#ocul_inter=true
	if Global.coneccion==1:
		sscore=true
		score()
		ocul_rule=false
		ocultar_rule()#Muestra la ruleta
		_on_Timer_timeout()
		$artico.hide()#Oculta la ruleta 
		
	if Global.coneccion==1:
		
		sscore=true
		score()
		ocul_rule=false
		ocultar_rule()
		_on_Timer_timeout()
		$bosque.hide()
		
	if Global.coneccion==1:		
		
		sscore=true
		score()
		ocul_rule=false
		ocultar_rule()
		_on_Timer_timeout()
		$jungla.hide()
		
	if Global.coneccion==1:
		
		sscore=true
		score()
		ocul_rule=false
		ocultar_rule()
		_on_Timer_timeout()
		$sabana.hide()
		
	if Global.coneccion==1:
		
		sscore=true
		score()
		ocul_rule=false
		ocultar_rule()
		_on_Timer_timeout()
		$agua.hide()
		
	if Global.coneccion==1:
		
		sscore=true
		score()
		ocul_rule=false
		ocultar_rule()
		_on_Timer_timeout()
		$Cielo.hide()

#--------------------------------------------------------------------------------------

	if Global.coneccion==0:
		sscore=false
		score()
		$Principio/titulo.text = "tucan´s animal adventure"
		princi()#Mueztra el interfaz
		$artico.hide()#Oculta la pregunta
		
	if Global.coneccion==0:
		sscore=false
		score()
		$Principio/titulo.text = "tucan´s animal adventure"
		princi()
		$bosque.hide()
		
	if Global.coneccion==0:
		sscore=false
		score()
		$Principio/titulo.text = "tucan´s animal adventure"
		princi()
		$jungla.hide()
		
	if Global.coneccion==0:
		sscore=false
		score()
		$Principio/titulo.text = "tucan´s animal adventure"
		princi()
		$sabana.hide()
		
	if Global.coneccion==0:
		sscore=false
		score()
		$Principio/titulo.text = "tucan´s animal adventure"
		princi()
		$agua.hide()
		
	if Global.coneccion==0:
		sscore=false
		score()
		$Principio/titulo.text = "tucan´s animal adventure"
		princi()
		$Cielo.hide()
		
	Global.coneccion=8

func _on_ruleta_timeout():#<----- son 0.5s
	rule=false
	ocul_rule=true
	ocul_inter=false
	ocultar_rule()
	ocult_inter()
	$time_ruleta.stop()

