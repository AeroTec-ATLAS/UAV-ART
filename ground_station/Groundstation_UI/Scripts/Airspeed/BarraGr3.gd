extends Sprite


func _on_Sprite_Leitura(array2, pinit, init):#movimentação da barra
	position.y =1640.279 -4.5 +29.5 + (49.3597/5.0 * float(array2[13]))
