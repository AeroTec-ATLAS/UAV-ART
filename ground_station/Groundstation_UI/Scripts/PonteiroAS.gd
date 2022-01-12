extends Sprite

var graus
var knot

func _ready():
	pass

func _on_Sprite_Leitura(array2): #Vamos deixar em nós? ou passar pra m/s?
	#print(array2[13])
	self.rotation_degrees= (float(array2[13]) * 39.5 / 5)
