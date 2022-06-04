extends Control

#Decide a altitude inicial

var init
var estado = 1
var as_init
var pinit2
signal ASIni
onready var only_once : bool = true
#func _ready():
	#init = int(global.array2[13])
	#as_init = init / 10
func _on_Sprite_Leitura(array2, pinit, init): #esta funcao detecta o primeiro valor de altitude
	#if float(array2[13]) >= 0:
	if estado == 1:
		init = int(array2[13])
		estado +=1
	if estado == 2:
		estado += 1
		as_init = init / 10 #com a divisao por 10 conseguimos arredondar mais facilmente, e so multiplicar a div por 10
		emit_signal("ASIni",as_init)

#func _process(delta):
#	#if float(global.array2[13]) >= 0:
#	if estado == 1:
#		init = int(global.array2[13])
#		estado +=1
#	if estado == 2:
#		estado += 1
#		as_init = init / 10 #com a divisao por 10 conseguimos arredondar mais facilmente, e so multiplicar a div por 10
