extends Polygon2D    
#Código para a movimentação dos polígonos novos
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN


func _ready():
	aux1 = SpawnerNumAs.contM1
	aux2 = SpawnerNumAs.contN1
	position.x = -806.57
	#print("ContM = ",SpawnerNum.contM)
	#print("ContN = ", SpawnerNum.contN)

func _process(delta): 
	if float(global.array2[9]) * 10 > ( InitialAlt.pinit * 10 + SpawnerNumAs.contM1 * 10):
		position.y = (Most7.position.y) -322 - 53 + -50 * (aux1 - 6) + (49.3597/5.0 * float(Debug.x)) 
	if float(global.array2[9]) * 10  < ( InitialAlt.pinit * 10 - SpawnerNumAs.contN1 * 10):
		position.y = (Most7.position.y) -29 - 53 + 50 * (aux2) + (49.3597/5.0 * float(Debug.x)) 

