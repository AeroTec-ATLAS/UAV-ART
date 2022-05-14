extends Polygon2D    
#Código para a movimentação dos polígonos novos
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN


func _ready():
	aux1 = SpawnerNum.contM
	aux2 = SpawnerNum.contN
	position.x = 313.0
	print("ContM = ",SpawnerNum.contM)
	print("ContN = ", SpawnerNum.contN)

func _process(delta):
	if float(global.array2[9]) * 10 > ( InitialAlt.pinit * 10 + SpawnerNum.contM * 10):
		position.y = (Most7.position.y) -322 + -50 * (aux1 - 6) + (49.0/10 * float(global.array2[9])) 
	if float(global.array2[9])* 10 < ( InitialAlt.pinit * 10 - SpawnerNum.contN * 10):
		position.y = (Most7.position.y) -29 + 50 * (aux2) + (49.0/10 * float(global.array2[9])) 
