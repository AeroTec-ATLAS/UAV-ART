extends Polygon2D

var aux
var estado = 1
#func _ready():
	#position.y = Leitor.pinit*-10 -3.76197*float(Debug.x)


func _on_Sprite_Leitura(array2, pinit, init):
	#position.y = 0
	if estado ==1 :
		#position.y = -pinit*10 -3.76197*float(Debug.x) + (49.3597/10 * float(Debug.x))
		position.y = -pinit*10 -3.76197*float(Debug.x) - 90 - 0.173999786*pinit*10  #+ 5 * init #-90
		#position.y = -pinit*10 -3.76197*float(Debug.x) - 90 - 0.173999786*pinit*10 FUNCIONA
		aux = position.y
		estado +=1
		#print(pinit)
	position.y = 49.3597/10 * float(Debug.x) +aux
	print(position.y)
	#print(position.y)
	#print(Debug.x)
		#position.y = -pinit*10 -87.0 + (49.3597/10 * float(Debug.x)) #array2[9])
	#position.y = -87.0 + (49.3597/10 * float(Debug.x))
	#print(position.y)
	



