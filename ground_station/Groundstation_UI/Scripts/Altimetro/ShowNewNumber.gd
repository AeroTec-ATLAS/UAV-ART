extends RichTextLabel
# Este script exibe os novos números spawnados

var aux #salva os valores de contM
func _ready():
	aux = SpawnerNum.contM


func _process(delta):
	var dialog = str(InitialAlt.pinit * 10 +((aux)) * 10) 
	set_visible_characters(4)
	set_bbcode(dialog)
