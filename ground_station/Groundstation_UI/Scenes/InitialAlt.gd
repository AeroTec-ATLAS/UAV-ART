extends Control

var init
var estado = 1
var pinit
signal AltIni

func _on_Sprite_Leitura(array2): #esta funcao detecta o primeiro valor de altitude
	
	if float(array2[9]) > 0:
		if estado == 1:
			init = int(array2[9])
			estado +=1
	if estado == 2:
		estado += 1
		pinit = init / 10 #com a divisao por 10 conseguimos arredondar mais facilmente, e so multiplicar a div por 10
		emit_signal("AltIni",pinit)
