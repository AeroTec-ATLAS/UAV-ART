extends Sprite


func _ready():
	rotation_degrees = 0

func _on_Sprite_Leitura(array2): #movimentação de outra parte do horizonte artificial
	rotation = float(array2[3])
	
