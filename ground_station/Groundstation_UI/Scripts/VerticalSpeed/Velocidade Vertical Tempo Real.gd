extends RichTextLabel


func _ready():
	pass # Replace with function body.


func _on_Sprite_Leitura(array2):
	var dialog = array2[10]
	set_visible_characters(4)
	set_bbcode(dialog)
	#if (float(Debug.x) <= -65): #array2[13]
	#	set_bbcode("ERRO")
	
