extends Sprite
var roll
var array
var pitch

func _ready():
	rotation_degrees = 0
	
func _on_Sprite_Leitura(array2):


	rotation = float(array2[3])
	pitch = float(array2[1]) 
	position.y = 0 + (pitch * 4 * 180)/PI

	#ver se o lado que gira/sobe é o certo
	#usar os 3 ang?
	#aumentar a a imagem do mov interno, pq o aviao pode descer ou subir muito mais
