extends RichTextLabel

func _on_Sprite_Leitura(array2, pinit, init):
	var dialog = str(pinit * 10 - 40) 
	set_visible_characters(4)
	set_bbcode(dialog)
	
