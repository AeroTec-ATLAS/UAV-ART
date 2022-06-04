extends Polygon2D    
#Código para a movimentação dos polígonos novos positivos
#este código é muito semelhante ao script NumNeg, do altimetro, que está mais comentado
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN


func _ready():
	aux1 = SpawnerNumAs.contM1
	aux2 = SpawnerNumAs.contN1
	position.x = 312.0

func _process(_delta): 
	position.y = -29 +7 - 100 + 49.3597 * (aux2+3) + (49.3597/5.0 * float(global.array2[13])) 
