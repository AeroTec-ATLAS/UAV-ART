extends RichTextLabel
# Este script exibe os novos números spawnados

var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN

func _ready():
	aux1 = SpawnerNumVerticalSpeed.contM1
	aux2 = SpawnerNumVerticalSpeed.contN1
	print(aux1)
func _process(_delta): 
	#if float(global.array2[10]) * 2  >= ( 9 * 2):
		
		var dialog = str(aux1 * 2 + 2)
		set_visible_characters(4)
		set_bbcode(dialog)
	#if float(global.array2[10]) * 2 <= (- 4 * 2):
	#	var dialog = str(-aux2 * 2 - 2) 
	#	set_visible_characters(4)
	#	set_bbcode(dialog)
