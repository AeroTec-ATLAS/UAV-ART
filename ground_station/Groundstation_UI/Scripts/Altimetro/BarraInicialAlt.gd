extends Sprite

func _ready():
	#position.y = 27.0 + (49.3597/10.0 * 161.164)
	#position.y += 5
	#position.y =   -249 + (48.0/10 * float(array2[9]))
	#aux1 = SpawnerBarra.contBarraM
	#aux2 = SpawnerBarra.contBarraN
	#position.x = 313.0
		
	pass

func _on_Sprite_Leitura(array2,pinit):
	position.y = 27.0 + (49.3597/10.0 * float(array2[9])) #21.0
	#-249 + (48.0/10 * float(array2[9]))
	#pass
func _process(_delta):
	position.y = (27.0 + (49.3597/10.0 * float(global.array2[9])))

