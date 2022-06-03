extends Sprite

var aux

#func _process(_delta):
	#position.y = (1665+(49.3597/10.0 * float(Debug.x)))
	#print(position.y)


func _on_Sprite_Leitura(array2, pinit):
	aux = 4.93597 * pinit * 10
	position.y = (1665+(49.3597/10.0 * float(Debug.x))) - aux
	#position.y = (1665+(49.3597/10.0 * float(Debug.x))) - aux
	#print(position.y)
