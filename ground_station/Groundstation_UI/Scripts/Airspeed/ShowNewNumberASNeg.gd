extends RichTextLabel
# Este script exibe os novos números spawnados

var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN

func _ready():
	aux1 = SpawnerNumAs.contM1
	aux2 = SpawnerNumAs.contN1
func _process(_delta): 
	#if float(Debug.x) * 5  >= ( 9 * 5):
	#	var dialog = str(aux1 * 5 + 5)
	#	set_visible_characters(4)
	#	set_bbcode(dialog)
	#if float(global.array2[13]) * 5 <= (- 4 * 5):
		var dialog = str(-aux2 * 5 -5) 
		set_visible_characters(4)
		set_bbcode(dialog)
