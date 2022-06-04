extends Sprite


func _on_Sprite_Leitura(array2, pinit, init):#movimentação da barra
	position.y = -1642.434-4.5 +29.5 + (49.3597/2.0 * float(array2[12]))
