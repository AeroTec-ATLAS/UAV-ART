extends Sprite

var aux



func _on_Sprite_Leitura(array2, pinit, init):
	aux = 4.93597 * pinit * 10
	position.y = (-1615+(49.3597/10.0 * float(Debug.x))) - aux
	#position.y = (1665+(49.3597/10.0 * float(Debug.x))) - aux
	#print(position.y)
