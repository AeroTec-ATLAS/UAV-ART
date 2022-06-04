extends Polygon2D    
#Código para a movimentação dos polígonos novos
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN
var estado =1 
var aux
func _ready():
	aux1 = SpawnerNum.contM #com as variaveis aux, sempre vai ser salvo o valor de contM/contN no momento que o polígono foi spawnado, para que este mantenha o seu valor
	aux2 = SpawnerNum.contN
	position.x = 313.0

func _process(_delta): 
	if estado ==1 :#mais um vez é utilizado estado para executar uma vez, e feita correção de parâmetros
		position.y = -284.999786 + 120 + 98.7194/20 * float(global.array2[9]) - 49.3597
		aux = position.y
		estado +=1
	position.y = 49.3597/10 * float(global.array2[9]) - aux
