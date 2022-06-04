extends RichTextLabel
# Este script exibe os novos números spawnados

var aux1 #salva o ultimo valor do contM
var aux2 #salva o ultimo valor do contN

func _ready():
	aux1 = SpawnerNum.contM
	aux2 = SpawnerNum.contN
	#print(InitialAlt.pinit * 10 -(aux2+1) * 10)
	#print(SpawnerNum.contN)
	#$Sprite.connect()
	#SpawnNewNumber.aux3.connect("Leitura", self, "on_Sprite_Leitura")
	#$Sprite.connect("Leitura", self, "on_Sprite_Leitura",["array2","pinit"])
	#print(InitialAlt.pinit)
	#$Sprite.connect("Leitura", self, "_on_Sprite_Leitura")
	
	#var aux = get_tree().get_root().get_node("PFD")
	#aux.connect("Leitura",self,"on_Sprite_Leitura")
	#InitialAlt.connect("AltIni",self,"_Alt_Ini")
	
func _process(_delta): 
	#if float(Debug.x) * 10 > ( InitialAlt.pinit * 10 + 9 * 10):
	#	var dialog = str(InitialAlt.pinit * 10 + aux1 * 10 + 10)
	#	set_visible_characters(5)
	#	set_bbcode(dialog)
	#if float(Debug.x)* 10 < ( InitialAlt.pinit * 10 - 4 * 10):
	var dialog = str(InitialAlt.pinit * 10 -(aux2+1) * 10)
	#print(InitialAlt.pinit * 10 -(aux2+1) * 10)
	set_visible_characters(5)
	set_bbcode(dialog)
	#print(InitialAlt.pinit * 10 -(aux2+1) * 10)
	
