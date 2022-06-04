extends Sprite

var aux


func _on_Sprite_Leitura(array2, pinit, init):
	aux = 4.93597 * pinit * 10
	position.y = (1665+(49.3597/10.0 * float(array2[9]))) - aux
#todos estes coeficientes servem para corrigir parametros(altitude inicial,
#altitude inicial não coincidir com os números da barra,etc) e estes foram todos 
#obtidos através de regras de três simples
