extends Polygon2D

func _on_Sprite_Leitura(array2, pinit, init): #movimentação dos números que são criados ao inicializar o programa
		position.y = +298 - 6 -236.0 -49.3597 * 3 + (49.3597/5.0 * float(array2[13]))
	
