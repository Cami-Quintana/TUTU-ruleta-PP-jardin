extends Node

var puntos=0
var coneccion=4
var maxx=0
var solu=true

const SAVEFILEMAX= "User://SAVEFILEMAX.save"

func _ready():
	mejorpun()
	load_data()
	print(smax)

func mejorpun():
	if puntos>maxx:
		maxx=puntos
		
	if maxx>smax:
		smax=maxx
		save_data()


var smax=0



func load_data():
	var file = FileAccess.open("user://save_game.save", FileAccess.READ)
	print(file)
	if file ==null:
		save_data()
	else:
		smax = file.get_var()
	save_data()
	file=null
	return smax
func save_data():
	var file = FileAccess.open("user://save_game.save", FileAccess.WRITE)
	file.store_var(smax)
	file=null
	






