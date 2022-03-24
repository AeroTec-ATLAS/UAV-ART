extends Sprite


	#position.y += 5
	#position.y =   -249 + (48.0/10 * float(array2[9]))

func _on_Sprite_Leitura(array2):
	position.y = + (48.0/10 * float(array2[9]))
