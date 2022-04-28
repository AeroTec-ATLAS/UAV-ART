extends Sprite

func _ready():
	#rotation_degrees = 245
	pass
	

func _on_Sprite_Leitura(array2):
	print(array2[9])
	#rotation_degrees = ((float(array2[9]) * 180/50))
	rotation_degrees = ((((float(array2[9]) * 180/50))/10)-115)
