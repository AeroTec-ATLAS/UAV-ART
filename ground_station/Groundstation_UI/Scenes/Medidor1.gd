extends Sprite

func _on_Sprite_Leitura(array2):
	position.y =  -7 + (48.0/10 * float(array2[13]))
