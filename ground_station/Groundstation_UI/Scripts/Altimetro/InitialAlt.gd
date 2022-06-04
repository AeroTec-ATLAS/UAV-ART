extends Control

#Decide a altitude inicial

var init
var estado = 1
var pinit
signal AltIni



func _on_Sprite_Leitura(array2, pinit, init): #eventualmente pode ser usado para esimar o pinit quando está em outra cena
	if float(array2[9]) >= 0: 
		if estado == 1:
			init = int(array2[9])
			estado +=1
	if estado == 2:
		estado += 1
		pinit = init / 10 #com a divisao por 10 conseguimos arredondar mais facilmente, e so multiplicar a div por 10
		

func _process(_delta): #eventualmente pode ser usado para esimar o pinit
	if float(global.array2[9]) >= 0:
		if estado == 1:
			init = int(global.array2[9])
			estado +=1
		if estado == 2:
			estado += 1
			pinit = init / 10 #com a divisao por 10 conseguimos arredondar mais facilmente, e so multiplicar a div por 10
		#print("pinit",pinit)
		emit_signal("AltIni",pinit)

