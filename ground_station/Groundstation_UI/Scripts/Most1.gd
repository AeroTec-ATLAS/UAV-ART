extends Polygon2D



func _on_Sprite_Leitura(array2):
	position.y = 4 + (48.0/10 * float(array2[9]))
