extends Sprite

func _on_Sprite_Leitura(array2):
	position.y =   -50 + (48.0/10 * float(array2[13]))
	#valor do -50 tava com -250
	
