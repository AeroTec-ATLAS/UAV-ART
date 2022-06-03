extends Control

#Decide a altitude inicial

var init
#var init2
var estado = 1
var pinit
#var pinit2
signal AltIni

func _on_Sprite_Leitura(array2,pinit): #esta funcao detecta o primeiro valor de altitude
	if float(Debug.x) >= 0: 
		if estado == 1:
			init = int(Debug.x)
			estado +=1
	if estado == 2:
		estado += 1
		pinit = init / 10 #com a divisao por 10 conseguimos arredondar mais facilmente, e so multiplicar a div por 10
		#InitialAlt.emit_signal("AltIni",pinit)

func _process(_delta):
	if float(Debug.x) >= 0:
		if estado == 1:
			init = int(Debug.x)
			estado +=1
	if estado == 2:
		estado += 1
		pinit = init / 10 #com a divisao por 10 conseguimos arredondar mais facilmente, e so multiplicar a div por 10
		#print("pinit",pinit)
		emit_signal("AltIni",pinit)
