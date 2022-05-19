extends Polygon2D
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN

func _ready():
	#position.y = 27.0 + (49.3597/10.0 * 161.164)
	#position.y += 5
	#position.y =   -249 + (48.0/10 * float(array2[9]))
	aux1 = SpawnerBarra.contBarraM
	aux2 = SpawnerBarra.contBarraN
	#print("segundo")
	
	#print(aux1)
	#pass

func _process(delta):
	#print(aux1)
	position.x = 626.0 + 234  #296
	position.y = (27  - 822.5*(aux1) +574 + (49.3597/10.0 * Debug.x))
	#position.y = (600  - 822.5*(aux1) +296 + (49.3597/10.0 * Debug.x))
	
		#27.0  - 822.5*(aux1) +296 + (49.3597/10.0 * Debug.x)
		#print(position.y)
		#	position.x = 626.0 + 234
		#	position.y = (27.0  - 822.5*(aux1) -641 + (49.3597/10.0 * Debug.x))
