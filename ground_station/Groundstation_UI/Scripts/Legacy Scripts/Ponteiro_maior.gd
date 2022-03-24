extends Sprite

func _ready():
	rotation_degrees = 110.3
	

func _on_Sprite_Leitura(array2):
	print(array2[9])
	rotation_degrees = ((float(array2[9]) * 180/50)+110)

	
