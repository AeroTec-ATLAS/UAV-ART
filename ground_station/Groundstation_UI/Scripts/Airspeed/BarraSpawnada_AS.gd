extends Polygon2D
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN
var aux3
var aux4

func _ready():
	#position.y = 27.0 + (49.3597/10.0 * 161.164)
	#position.y += 5
	#position.y =   -249 + (48.0/10 * float(array2[9]))
	aux1 = SpawnerBarraAS.contBarraM_AS
	aux2 = SpawnerBarraAS.contBarraN_AS
	aux3 = SpawnerBarraAS.pos1
	aux4 = SpawnerBarraAS.neg1
	position.x = -1.5
	#print("entrouA")
	#print("first")
	
	
	#pass

func _process(_delta):
	#print(Debug.x)
	#print( -aux2*65)
	
	
	
	#if(float(Debug.x)):
	#if float(Debug.x)   >= ( aux1*65 ):
		#print("wtf")
		position.y = (-822.5 + 22.87286 + (49.3597/5.0 * float(global.array2[13])))
	#if float(Debug.x)   <= ( -aux2*65 ):
		#print("neg")
	#	position.y = (+822.5*2 - 22.87286 - 148  + (49.3597/5.0 * Debug.x))
		#print(Debug.x)
		#print(position.y)
	#print("Posição =" ,position.y)
	#print("Debug =" ,Debug.x)
	#position.y = (27.0 - 161.164*(aux1) -641 + (49.3597/5.0 * Debug.x))
	#if (aux4 == 1):
		#position.y = (27.0 + 161.164*(aux2) +641 - (49.3597/10.0 * Debug.x))
	#27.0 - 161.164*(aux1) -641 + (49.3597/10.0 * Debug.x)
	#print(position.y)
	
	
		#	position.x = 626.0 + 234
		#	position.y = (27.0  - 822.5*(aux1) -641 + (49.3597/10.0 * Debug.x))
