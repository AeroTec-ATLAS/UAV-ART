extends Sprite


func _ready():
	rotation_degrees = 0

func _on_Sprite_Leitura(array2):
	#print(array2[3])
	rotation = float(array2[3])
	
