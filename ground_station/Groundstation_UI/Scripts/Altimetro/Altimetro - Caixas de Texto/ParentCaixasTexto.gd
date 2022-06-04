extends Polygon2D

var aux
var estado = 1


func _on_Sprite_Leitura(array2, pinit, init):
	if estado ==1 : #o estado serve para o ajuste da posição do número (relativo a altitude inicial) seja feita apenas uma vez
		position.y = -pinit*10 -3.76197*float(array2[9]) - 93 - 0.173999786*pinit*10 + 3.76199 * init
		aux = position.y
		estado +=1
	position.y = 49.3597/10 * float(array2[9]) +aux #depois a posição corrigida é somada com a movimentação da barra




