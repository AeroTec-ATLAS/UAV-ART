extends Polygon2D

func _on_Sprite_Leitura(array2):
	position.y = -87.0 + (49.0/10 * float(array2[13]))



