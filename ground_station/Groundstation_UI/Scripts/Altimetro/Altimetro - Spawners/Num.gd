extends Polygon2D    
#Código para a movimentação dos polígonos novos
var aux #salva o ultimo valor do contM


func _ready():
	aux = SpawnerNum.contM
	position.x = 313.0
	print(SpawnerNum.contM)

func _process(delta):
	position.y = (Most7.position.y) -334 + -50 * (aux - 6) + (49.0/10 * float(global.array2[9])) 
