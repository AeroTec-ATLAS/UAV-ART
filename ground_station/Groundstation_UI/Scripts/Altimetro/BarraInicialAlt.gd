extends Sprite

var aux


func _on_Sprite_Leitura(array2, pinit, init):
	aux = 4.9359702 * pinit * 10 + 49.3597/10.0  #todos estes coeficientes servem para corrigir parametros(altitude inicial, altitude inicial não coincidir com os números da barra,etc) e estes foram todos obtidos através de regras de três simples
	position.y = 27.0 + (49.3597/10.0 * float(global.array2[9])) - aux
#49.3597/10.0 é o movimento da barra (para cada 10 metros a barra se movimenta 49.3597 unidades
#4.9359702 * pinit * 10 é a correção da altitude inicial
	print(pinit)
