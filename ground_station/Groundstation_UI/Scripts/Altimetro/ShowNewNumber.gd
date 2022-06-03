extends RichTextLabel
# Este script exibe os novos números spawnados

var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN

func _ready():
	aux1 = SpawnerNum.contM
	aux2 = SpawnerNum.contN
func _process(_delta): 
	#if float(Debug.x) * 10 > ( InitialAlt.pinit * 10 + 9 * 10):
		var dialog = str(InitialAlt.pinit * 10 + aux1 * 10 + 10)
		set_visible_characters(6)
		set_bbcode(dialog)
	#if float(Debug.x)* 10 < ( InitialAlt.pinit * 10 - 4 * 10):
	#	var dialog = str(InitialAlt.pinit * 10 -((aux2+1)) * 10) 
	#	set_visible_characters(5)
	#	set_bbcode(dialog)
