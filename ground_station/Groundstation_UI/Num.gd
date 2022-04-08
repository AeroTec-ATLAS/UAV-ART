extends Polygon2D



func _ready():
	#position.y = 0
	position.x = 313.0
	#print("criou de vdd")
	#position.y = -50 * (SpawnerNum.contM - 5)
	print(SpawnerNum.contM)
	#pass

func _process(delta):
	#position.x = 313.0
	position.y = (Most7.position.y) -321 + -50 * (SpawnerNum.contM - 5) + (49.0/10 * float(global.array2[9])) 
	
	#-522 da certo
#func _ready():
	#position.y = 0
#	position.x = 313.0
	#position.y = -38
#	pass
#func _process(delta):
	
	#position.y = -84.4 + (49.0/10 * float(global.array2[9]))
	#print(float(global.array2[9]))
	#trocar delta pra array2 e ver se da certo
