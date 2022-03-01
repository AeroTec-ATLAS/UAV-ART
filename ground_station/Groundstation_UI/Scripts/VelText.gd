extends RichTextLabel


func _ready():
	pass # Replace with function body.


func _on_Sprite_Leitura(array2):
	var dialog = array2[9]
	set_bbcode(dialog)
	
	
	
