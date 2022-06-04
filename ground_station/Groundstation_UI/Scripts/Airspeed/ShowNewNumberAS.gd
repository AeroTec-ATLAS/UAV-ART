extends RichTextLabel
# Este script exibe os novos números spawnados positivos
#script muito semelhante ao ShowNewNumber do altimetro, que está melhor comentado
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN

func _ready():
	aux1 = SpawnerNumAs.contM1
	aux2 = SpawnerNumAs.contN1
func _process(_delta): 
	var dialog = str(aux1 * 5 + 5)
	set_visible_characters(4)
	set_bbcode(dialog)
