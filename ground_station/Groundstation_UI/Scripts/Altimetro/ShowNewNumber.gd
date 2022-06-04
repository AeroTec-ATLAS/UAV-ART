extends RichTextLabel
# Este script exibe os novos números spawnados

var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN

func _ready():
	aux1 = SpawnerNum.contM
	aux2 = SpawnerNum.contN
func _process(_delta): 
		var dialog = str(global.pinit * 10 + aux1 * 10 + 10)#altitude inicial + número de caixas criadas e outros parâmetros de correção
		set_visible_characters(6)
		set_bbcode(dialog)
