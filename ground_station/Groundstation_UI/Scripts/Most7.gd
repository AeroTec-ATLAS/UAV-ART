extends Polygon2D

func _on_Sprite_Leitura(array2):
	position.y = -84.4 + (49.0/10 * float(array2[9]))



