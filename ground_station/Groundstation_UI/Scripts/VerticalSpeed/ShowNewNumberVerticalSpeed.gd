extends RichTextLabel
# Este script exibe os novos números spawnados
#script muito semelhante ao ShowNewNumber do altimetro, que está melhor comentado
var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN

func _ready():
	aux1 = SpawnerNumVerticalSpeed.contM1
	aux2 = SpawnerNumVerticalSpeed.contN1
func _process(_delta): 
	var dialog = str(aux1 * 2 + 2)
	set_visible_characters(4)
	set_bbcode(dialog)
