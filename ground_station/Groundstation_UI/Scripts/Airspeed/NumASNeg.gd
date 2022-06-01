extends Polygon2D    
#Código para a movimentação dos polígonos novos
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN


func _ready():
	aux1 = SpawnerNumAs.contM1
	aux2 = SpawnerNumAs.contN1
	position.x = 312.0
	#position.x = -806.57
	#print("ContM = ",SpawnerNum.contM)
	#print("ContN = ", SpawnerNum.contN)

func _process(_delta): 
	#if float(Debug.x)*5 >= ( SpawnerNumAs.contM1 * 5):#global.array2[13]
		#print("aaaa")
		
		#position.y = -49.3597 * (aux1-6) -431.0 +29.5 + (49.3597/5.0 * float(Debug.x))
		#position.y = (CaixasTextoAirspeed.position.y) -322 - 53 + -50 * (aux1 - 6) + (49.3597/5.0 * float(Debug.x)) 
		#print(position.x)
		#position.y = (Most7.position.y) -22 - 53 + -50 * (aux1 - 6) + (49.3597/5.0 * float(Debug.x)) 
	#if float(Debug.x) * 5  <= ( - SpawnerNumAs.contN1 * 5):
		position.y = -29 +7 - 100 + 49.3597 * (aux2+3) + (49.3597/5.0 * float(Debug.x)) 
