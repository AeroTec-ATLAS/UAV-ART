extends Sprite
var roll
var array
var pitch

func _ready():
	rotation_degrees = 0
	
func _on_Sprite_Leitura(array2, pinit, init): #faz com que uma das rodas do horizonte gire
	rotation = float(array2[3])
	pitch = float(array2[1]) 
	position.y = 0 + (pitch * 4 * 180)/PI

