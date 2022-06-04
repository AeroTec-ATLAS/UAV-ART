extends Polygon2D    
#Código para a movimentação dos polígonos novos
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN
var estado =1 
var aux
func _ready():
	aux1 = SpawnerNum.contM
	aux2 = SpawnerNum.contN
	position.x = 313.0
	#print("ContM = ",SpawnerNum.contM)
	#print("ContN = ", SpawnerNum.contN)

func _process(_delta): 
	if estado ==1 :
		#position.y = -pinit*10 -3.76197*float(Debug.x) + (49.3597/10 * float(Debug.x))
		position.y = -284.999786 + 120 + 98.7194/20 * float(Debug.x)#InitialAlt.pinit* -10 #-3.76197*float(Debug.x)
		aux = position.y
		estado +=1
	#if float(Debug.x) * 10 >= ( InitialAlt.pinit * 10 + SpawnerNum.contM * 10):
	#	position.y = (Most7.position.y) -323 - 53 + -50 * (aux1 - 6) + (49.3597/10.0 * float(Debug.x))
	#if float(Debug.x)* 10 <= ( InitialAlt.pinit * 10 - SpawnerNum.contN * 10):
	#position.y = (Most7.position.y) -25 - 49.3597*2 + 49.3597 * (aux2+3) + (49.3597/10.0 * float(Debug.x))
	position.y = 49.3597/10 * float(Debug.x) - aux
	#print(position.y)
